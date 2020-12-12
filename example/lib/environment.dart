import 'package:flutter/services.dart';

class Environment {
  static Future<String> loadKeys() => rootBundle.loadString('.keys');
}
