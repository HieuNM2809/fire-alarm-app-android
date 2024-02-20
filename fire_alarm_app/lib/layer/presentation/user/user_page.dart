import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';

class UserPage extends StatefulWidget {
  static const String routeName = '/user';

  const UserPage({super.key});

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  final _userBloc = UserBloc(UnUserState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserScreen(userBloc: _userBloc),
    );
  }
}
