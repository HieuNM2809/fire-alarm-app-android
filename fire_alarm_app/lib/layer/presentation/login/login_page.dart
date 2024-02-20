import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc(UnLoginState());
  final userRepository = UserRepository();
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
