import 'package:fire_alarm_app/config/go_router_config.dart';
import 'package:fire_alarm_app/layer/data/repos/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GoRouterConfig goRouterConfig = GoRouterConfig();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '',
      builder: (context, child) => child!,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: goRouterConfig.router,
    );
  }
}
