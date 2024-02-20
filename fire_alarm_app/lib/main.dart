import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'layer/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterBackgroundService().invoke('setAsBackground');
  runApp(const MyApp());
}

/// Get state from anywhere
class StateManager {
  /// Use NavigatorState to store global key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
