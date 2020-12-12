import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';

import '../../models/place.dart';
import '../../services/google_maps_service.dart';
import '../components/logo_widget.dart';
import '../components/predictions_widget.dart';
import '../components/search_field_widget.dart';

class PageFullScreen extends StatefulWidget {
  final String apiKey;
  final String baseUrl;
  final Client httpClient;

  final InputDecoration inputDecoration;

  final bool autoFocus;

  final bool showLogo;
  final Widget logoWidget;
  final Widget closeWidget;

  const PageFullScreen({
    Key key,
    @required this.apiKey,
    @required this.baseUrl,
    this.httpClient,
    this.inputDecoration,
    this.autoFocus = true,
    this.showLogo = true,
    this.logoWidget,
    this.closeWidget,
  }) : super(key: key);

  @override
  _PageFullScreenState createState() => _PageFullScreenState();
}

class _PageFullScreenState extends State<PageFullScreen> {
  GoogleMapService _googleMapService;

  StreamController<List<Prediction>> _streamController =
      StreamController.broadcast();

  bool _isLoading = false;
  bool _isLoadingDetails = false;

  void _getPlaceDetails(Prediction prediction) {
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
      apiKey: widget.apiKey,
      baseUrl: widget.baseUrl,
      httpClient: widget.httpClient,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: SearchFieldWidget(
            onChanged: _search,
            inputDecoration: widget.inputDecoration,
            autoFocus: widget.autoFocus,
          ),
          leading: widget.closeWidget != null
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: widget.closeWidget,
                )
              : null,
        ),
        body: CustomScrollView(
          slivers: [
            StreamBuilder<List<Prediction>>(
              stream: _streamController.stream,
              builder: (_, snapshot) {
                if (snapshot.hasData && !snapshot.hasError)
                  return predictionsWidget(
                    predictions: snapshot.data,
                    onPressedChoosePrediction: _getPlaceDetails,
                  );
                return SliverToBoxAdapter();
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
            )
          ],
        ),
      );

  @override
  void dispose() {
    _googleMapService.dispose();
    _streamController.close();
    super.dispose();
  }
}
