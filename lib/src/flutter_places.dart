import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../flutter_places.dart';
import 'models/search_options.dart';
import 'ui/pages/page_bottom_sheet.dart';
import 'ui/pages/page_full_screen.dart';
import 'ui/pages/page_overlay.dart';
import 'utils/enums.dart';

class FlutterPlaces {
  static Future<Place> show({
    @required BuildContext context,
    @required String apiKey,
    ModeType modeType = ModeType.FULL_SCREEN,
    String baseUrl,
    Client httpClient,
    TextStyle textStyle,
    InputDecoration inputDecoration,
    Duration textChangeDuration,
    Widget clearButton,
    bool showClearButton,
    int minSearchCharacters,
    bool autoFocus = true,
    bool showLogo = true,
    Widget logoWidget,
    Widget closeWidget,
    Widget itemLeading,
    Widget itemTrailing,
    EdgeInsetsGeometry overlayMargin = const EdgeInsets.all(10),
    double radius = 5,
    SearchOptions searchOptions,
  }) {
    switch (modeType) {
      case ModeType.OVERLAY:
        return showDialog(
          context: context,
          builder: (_) => Material(
            color: Colors.transparent,
            child: PageOverlay(
              apiKey: apiKey,
              baseUrl: baseUrl,
              httpClient: httpClient,
              textStyle: textStyle,
              inputDecoration: inputDecoration,
              textChangeDuration: textChangeDuration,
              clearButton: clearButton,
              showClearButton: showClearButton,
              minSearchCharacters: minSearchCharacters,
              autoFocus: autoFocus,
              showLogo: showLogo,
              logoWidget: logoWidget,
              closeWidget: closeWidget,
              itemLeading: itemLeading,
              itemTrailing: itemTrailing,
              overlayMargin: overlayMargin,
              radius: radius,
              searchOptions: searchOptions,
            ),
          ),
        );

      case ModeType.BOTTOM_SHEET:
        return showModalBottomSheet<Place>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radius),
            ),
          ),
          builder: (_) => PageBottomSheet(
            apiKey: apiKey,
            baseUrl: baseUrl,
            httpClient: httpClient,
            textStyle: textStyle,
            inputDecoration: inputDecoration,
            textChangeDuration: textChangeDuration,
            clearButton: clearButton,
            showClearButton: showClearButton,
            minSearchCharacters: minSearchCharacters,
            autoFocus: autoFocus,
            showLogo: showLogo,
            logoWidget: logoWidget,
            closeWidget: closeWidget,
            itemLeading: itemLeading,
            itemTrailing: itemTrailing,
            searchOptions: searchOptions,
          ),
        );

      default:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PageFullScreen(
              apiKey: apiKey,
              baseUrl: baseUrl,
              httpClient: httpClient,
              textStyle: textStyle,
              inputDecoration: inputDecoration,
              textChangeDuration: textChangeDuration,
              clearButton: clearButton,
              showClearButton: showClearButton,
              minSearchCharacters: minSearchCharacters,
              autoFocus: autoFocus,
              showLogo: showLogo,
              logoWidget: logoWidget,
              closeWidget: closeWidget,
              itemLeading: itemLeading,
              itemTrailing: itemTrailing,
              searchOptions: searchOptions,
            ),
          ),
        );
    }
  }
}
