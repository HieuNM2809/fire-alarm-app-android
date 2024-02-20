import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/register/index.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerBloc = RegisterBloc(UnRegisterState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterScreen(registerBloc: _registerBloc),
    );
  }
}
