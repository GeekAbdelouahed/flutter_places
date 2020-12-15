import 'package:google_maps_webservice/places.dart';

class SearchOptions {
  final String sessionToken;
  final num offset;
  final Location origin;
  final Location location;
  final num radius;
  final String language;
  final List<String> types;
  final List<Component> components;
  final bool strictbounds;
  final String region;

  SearchOptions({
    this.sessionToken,
    this.offset,
    this.origin,
    this.location,
    this.radius,
    this.language,
    this.types,
    this.components,
    this.strictbounds,
    this.region,
  });
}
