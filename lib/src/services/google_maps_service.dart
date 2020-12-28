import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';

import '../models/search_options.dart';

class GoogleMapService {
  GoogleMapsPlaces _places;

  GoogleMapService(
    apiKey, {
    String baseUrl,
    Client httpClient,
  }) {
    _places = GoogleMapsPlaces(
      apiKey: apiKey,
      baseUrl: baseUrl,
      httpClient: httpClient,
    );
  }

  Future<List<Prediction>> search(
    String query, {
    Function(bool) onLoading,
    Function(List<Prediction>) onSuccess,
    Function(String) onError,
    SearchOptions searchOptions,
  }) async {
    onLoading?.call(true);
    try {
      final res = await _places.autocomplete(
        query,
        sessionToken: searchOptions?.sessionToken,
        origin: searchOptions?.origin,
        location: searchOptions?.location,
        offset: searchOptions?.offset,
        radius: searchOptions?.radius,
        language: searchOptions?.language,
        types: searchOptions?.types,
        components: searchOptions?.components,
        strictbounds: searchOptions?.strictbounds,
        region: searchOptions?.region,
      );

      if (res.errorMessage?.isNotEmpty ??
          false || res.status == 'REQUEST_DENIED') {
        onError?.call(res.errorMessage);
        return Future.error(res.errorMessage);
      }

      onLoading?.call(false);
      onSuccess?.call(res.predictions);
      return res.predictions;
    } catch (e) {
      print(e);
      onLoading?.call(false);
      onError?.call('$e');
      return Future.error('$e');
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
      onError?.call('$e');
      return Future.error('$e');
    }
  }

  void dispose() {
    _places.dispose();
  }
}
