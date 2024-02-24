import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/utils/share_pref.dart';
import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc(UnLoginState());
  final userRepository = UserRepository();
  SharePref sharePref = SharePref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(
        loginBloc: _loginBloc,
        userRepository: userRepository,
      ),
    );
  }
}
