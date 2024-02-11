import 'package:fire_alarm_app/main.dart';
import 'package:go_router/go_router.dart';

import '../layer/presentation/login/login.dart';

class GoRouterConfig {
  final router = GoRouter(
    navigatorKey: StateManager.navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
    ],
  );
}
