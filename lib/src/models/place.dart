import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';

class Place {
  final Prediction prediction;
  final PlaceDetails placeDetails;

  Place({
    @required this.prediction,
    @required this.placeDetails,
  });
}
