import 'package:flutter/material.dart';

import 'layer/presentation/my_app.dart';

void main() {
  runApp(const MyApp());
}

/// Get state from anywhere
class StateManager {
  /// Use NavigatorState to store global key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
