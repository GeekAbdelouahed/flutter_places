## Flutter Places

[![pub package](https://img.shields.io/pub/v/flutter_places.svg)](https://pub.dartlang.org/packages/flutter_places)

Flutter places fully customizable widget for autocomplete, compatible with Light and Dark mode.

# FullScreen Mode

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/fullscreen-light.png" height="400">
      </td>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/fullscreen-dark.png" height="400">
      </td>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/fullscreen-ios.png" height="400">
      </td>
  </table>
</div>


# Overlay Mode

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/overlay-light.png" height="400">
      </td>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/overlay-dark.png" height="400">
      </td>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/overlay-ios.png" height="400">
      </td>
  </table>
</div>

# Bottomsheet Mode

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/bottomsheet-light.png" height="400">
      </td>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/bottomsheet-dark.png" height="400">
      </td>
      <td style="text-align: center">
        <img src="https://github.com/GeekAbdelouahed/flutter_places/raw/master/screenshots/bottomsheet-ios.png" height="400">
      </td>
  </table>
</div>


## Usage

[Include 'flutter_places' from Dart Pub.](https://pub.dartlang.org/packages/flutter_places)

```yaml
# pubspec.yaml

dependencies:
  flutter:
    sdk: flutter
  flutter_places: <last-version>
```

Next, import 'flutter_places.dart' into your dart code.

```dart
import 'package:flutter_places/flutter_places.dart';
```

Example

```dart

const apiKey = "API_KEY";

Place place = await FlutterPlaces.show(
                    context: context,
                    apiKey: apiKey,
                    modeType: ModeType.OVERLAY,
                  );

```
The library use [google_maps_webservice](https://github.com/lejard-h/google_maps_webservice) library which directly refer to the official [documentation](https://developers.google.com/maps/web-services/) for google maps web service. 
