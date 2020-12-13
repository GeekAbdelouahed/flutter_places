import 'package:flutter/services.dart';

class Environment {
  static Future<String> getKey() => rootBundle.loadString('.keys');
}
