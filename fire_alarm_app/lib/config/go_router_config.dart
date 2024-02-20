import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:fire_alarm_app/layer/presentation/register/index.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:go_router/go_router.dart';

import '../layer/presentation/home/home_page.dart';

class GoRouterConfig {
  final router = GoRouter(
    navigatorKey: StateManager.navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return InitAppPage();
        },
      ),
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: RegisterPage.routeName,
        builder: (context, state) {
          return RegisterPage();
        },
      ),
      GoRoute(
        path: UserPage.routeName,
        builder: (context, state) {
          return const UserPage();
        },
      ),
      GoRoute(
        path: InitAppPage.routeName,
        builder: (context, state) {
          return InitAppPage();
        },
      ),
    ],
  );
}
