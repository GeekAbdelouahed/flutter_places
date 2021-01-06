import 'dart:io';

class AppConstants {
  static bool isWeb() {
    try {
      return !Platform.isAndroid && !Platform.isIOS;
    } catch (e) {
      return true;
    }
  }
}
