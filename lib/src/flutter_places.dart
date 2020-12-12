import 'package:flutter/material.dart';

import '../flutter_places.dart';
import 'ui/pages/page_bottom_sheet.dart';
import 'ui/pages/page_full_screen.dart';
import 'ui/pages/page_overlay.dart';
import 'utils/enums.dart';

class FlutterPlaces {
  static Future<Place> show({
    @required BuildContext context,
    @required String apiKey,
    ModeType modeType = ModeType.FULL_SCREEN,
  }) {
    final builder = (context) {
      switch (modeType) {
        case ModeType.OVERLAY:
          return PageOverlay();
        case ModeType.BOTTOM_SHEET:
          return PageBottomSheet();
        default:
          return PageFullScreen(
            apiKey: apiKey,
          );
      }
    };

    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: builder,
      ),
    );
  }
}
