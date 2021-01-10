import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';

import '../../models/place.dart';
import '../../models/search_options.dart';
import '../../services/google_maps_service.dart';
import '../../utils/extensions.dart';
import '../components/logo_widget.dart';
import '../components/predictions_widget.dart';
import '../components/search_field_widget.dart';

class PageBottomSheet extends StatefulWidget {
  final String apiKey;
  final String baseUrl;
  final Client httpClient;

  final TextStyle textStyle;
  final InputDecoration inputDecoration;
  final Duration textChangeDuration;
  final Widget clearButton;
  final bool showClearButton;
  final int minSearchCharacters;
  final bool autoFocus;

  final bool showLogo;
  final Widget logoWidget;
  final Widget closeWidget;

  final Widget itemLeading;
  final Widget itemTrailing;

  final SearchOptions searchOptions;

  const PageBottomSheet({
    Key key,
    @required this.apiKey,
    @required this.baseUrl,
    this.httpClient,
    this.textStyle,
    this.inputDecoration,
    this.textChangeDuration,
    this.clearButton,
    this.showClearButton,
    this.minSearchCharacters,
    this.autoFocus = true,
    this.showLogo = true,
    this.logoWidget,
    this.closeWidget,
    this.itemLeading,
    this.itemTrailing,
    this.searchOptions,
  }) : super(key: key);

  @override
  _PageBottomSheetState createState() => _PageBottomSheetState();
}

class _PageBottomSheetState extends State<PageBottomSheet> {
  GoogleMapService _googleMapService;

  StreamController<List<Prediction>> _streamController =
      StreamController.broadcast();

  bool _isLoading = false;
  bool _isLoadingDetails = false;

  void _getPlaceDetails(Prediction prediction) {
    if (_isLoadingDetails) return;

    _googleMapService.getPlaceDetails(
      prediction.placeId,
      onLoading: (isLoading) {
        setState(() {
          _isLoadingDetails = isLoading;
        });
      },
      onSuccess: (placeDetails) {
        final Place place =
            Place(prediction: prediction, placeDetails: placeDetails);
        Navigator.of(context).pop(place);
      },
      onError: (error) {
        _streamController.addError(error);
      },
    );
  }

  void _search(String query) {
    if (_isLoadingDetails) return;

    _googleMapService.search(
      query,
      searchOptions: widget.searchOptions,
      onLoading: (isLoading) {
        setState(() {
          _isLoading = isLoading;
        });
      },
      onSuccess: (predictions) {
        _streamController.add(predictions);
      },
      onError: (error) {
        _streamController.addError(error);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _googleMapService = GoogleMapService(
      widget.apiKey,
      baseUrl: widget.baseUrl,
      httpClient: widget.httpClient,
    );
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppBar(
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: Colors.transparent,
              title: SearchFieldWidget(
                onChanged: _search,
                textStyle: widget.textStyle ??
                    TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                    ),
                inputDecoration: widget.inputDecoration ??
                    InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: context.isDarkMode
                            ? Theme.of(context).hintColor
                            : Colors.black.withOpacity(.5),
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                    ),
                autoFocus: widget.autoFocus,
                clearButton: const Icon(Icons.close),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Material(
              child: const Divider(),
            ),
          ),
          StreamBuilder<List<Prediction>>(
            stream: _streamController.stream,
            builder: (_, snapshot) {
              if (snapshot.hasData && !snapshot.hasError)
                return predictionsWidget(
                  predictions: snapshot.data,
                  onPressedChoosePrediction: _getPlaceDetails,
                  itemLeading: widget.itemLeading,
                  itemTrailing: widget.itemTrailing,
                );
              return SliverToBoxAdapter();
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    margin: const EdgeInsets.symmetric(horizontal: 29),
                    child: Visibility(
                      visible: _isLoading || _isLoadingDetails,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  if (widget.showLogo) widget.logoWidget ?? LogoWidget(),
                ],
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _googleMapService.dispose();
    _streamController.close();
    super.dispose();
  }
}
