import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/home/index.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc(const UnHomeState());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(homeBloc: _homeBloc),
    );
  }
}
