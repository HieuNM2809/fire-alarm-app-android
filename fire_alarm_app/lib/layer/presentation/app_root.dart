import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:fire_alarm_app/utils/share_pref.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoot extends StatefulWidget {
  static const String routeName = '/app_root';

  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();
    checkAccessToken();
  }

  void checkAccessToken() async {
    SharePref sharePref = SharePref();
    UserRepository userRepository = UserRepository();
    final username = await sharePref.read('username');
    final password = await sharePref.read('password');
    if (username != '' && password != '') {
      userRepository.loginApp(username, password);
    } else {
      GoRouter.of(StateManager.navigatorKey.currentContext!)
          .go(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
