import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';

class GoogleMapSerivce {
  final String apiKey;
  final String baseUrl;
  final httpClient;

  GoogleMapsPlaces _places;

  GoogleMapSerivce({
    @required this.apiKey,
    this.baseUrl,
    this.httpClient,
  }) {
    _places = GoogleMapsPlaces(
      apiKey: this.apiKey,
      baseUrl: this.baseUrl,
      httpClient: this.httpClient,
    );
  }

  Future<List<Prediction>> search(
    String query, {
    Function(bool) onLoading,
    Function(List<Prediction>) onSuccess,
    Function(String) onError,
  }) async {
    onLoading?.call(true);
    try {
      final res = await _places.autocomplete(query);

      if (res.errorMessage?.isNotEmpty ??
          false || res.status == 'REQUEST_DENIED') {
        onError?.call(res.errorMessage);
        return Future.error(res.errorMessage);
      }

      onLoading?.call(false);
      onSuccess?.call(res.predictions);
      return res.predictions;
    } catch (e) {
      onLoading?.call(false);
      onError?.call(e);
      return Future.error(e);
    }
  }

  Future<PlaceDetails> getPlaceDetails(
    String placeId, {
    Function(bool) onLoading,
    Function(PlaceDetails) onSuccess,
    Function(String) onError,
  }) async {
    onLoading?.call(true);
    try {
      final res = await _places.getDetailsByPlaceId(placeId);

      if (res.errorMessage?.isNotEmpty ??
          false || res.status == 'REQUEST_DENIED') {
        onError?.call(res.errorMessage);
        return Future.error(res.errorMessage);
      }

      onLoading?.call(false);

      onSuccess?.call(res.result);
      return res.result;
    } catch (e) {
      onLoading?.call(false);
      onError?.call(e);
      return Future.error(e);
    }
  }

  void dispose() {
    _places.dispose();
  }
}
