import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

import '../../models/place.dart';
import '../components/search_field.dart';
import '../components/prediction.dart';
import '../components/logo.dart';
import '../../services/google_maps_service.dart';

class PageFullScreen extends StatefulWidget {
  final String apiKey;
  final String baseUrl;
  final httpClient;

  final InputDecoration inputDecoration;
  final bool autoFocus;
  final Widget logo;
  final double logoHeight;
  final double logoWidth;
  final EdgeInsetsGeometry logoMargin;

  const PageFullScreen({
    Key key,
    @required this.apiKey,
    this.baseUrl,
    this.httpClient,
    this.inputDecoration,
    this.autoFocus = true,
    this.logo,
    this.logoHeight,
    this.logoWidth,
    this.logoMargin,
  }) : super(key: key);

  @override
  _PageFullScreenState createState() => _PageFullScreenState();
}

class _PageFullScreenState extends State<PageFullScreen> {
  GoogleMapSerivce _googleMapSerivce;

  StreamController<List<Prediction>> _streamController =
      StreamController.broadcast();

  bool _isLoading = false;
  bool _isLoadingDetails = false;

  void _getPlaceDetails(Prediction prediction) {
    _googleMapSerivce.getPlaceDetails(
      prediction.placeId,
      onLoading: (isLoading) {
        setState(() {
          _isLoadingDetails = isLoading;
        });
      },
      onSuccess: (placeDtails) {
        final Place place =
            Place(prediction: prediction, placeDetails: placeDtails);
        Navigator.of(context).pop(place);
      },
      onError: (error) {
        _streamController.addError(error);
      },
    );
  }

  void _search(String query) {
    if (_isLoadingDetails) return;

    _googleMapSerivce.search(
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

    _googleMapSerivce = GoogleMapSerivce(
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
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<List<Prediction>>(
            stream: _streamController.stream,
            builder: (_, snapshot) {
              if (snapshot.hasData && !snapshot.hasError)
                return _buildItems(snapshot.data);
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
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Visibility(
                      visible: _isLoading || _isLoadingDetails,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  LogoWidget(
                    height: widget.logoHeight,
                    width: widget.logoWidth,
                    child: widget.logo,
                  ),
                ],
              ),
            ),
          )
        ],
      ));

  Widget _buildItems(List<Prediction> predictions) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 70),
            child: Column(
              children: [
                if (index > 0) const Divider(),
                PredictionWidget(
                  prediction: predictions[index],
                  onPressed: () {
                    _getPlaceDetails(predictions[index]);
                  },
                ),
              ],
            ),
          ),
          childCount: predictions.length,
        ),
      );

  @override
  void dispose() {
    _googleMapSerivce.dispose();
    _streamController.close();
    super.dispose();
  }
}
