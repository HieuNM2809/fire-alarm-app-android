import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';
import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';

class InitAppPage extends StatefulWidget {
  static const String routeName = '/initApp';

  @override
  _InitAppPageState createState() => _InitAppPageState();
}

class _InitAppPageState extends State<InitAppPage> {
  final _initAppBloc = InitAppBloc(UnInitAppState());
  Widget? page1, page2;
  List<Widget> listWidget = [];

  @override
  void initState() {
    page1 = const HomePage();
    page2 = const UserPage();
    listWidget = [page1!, page2!];
    _initAppBloc.add(ChangePageInitAppEvent(index: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InitAppScreen(
        initAppBloc: _initAppBloc,
        widgetChild: listWidget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 180, 59),
        onTap: (value) =>
            _initAppBloc.add(ChangePageInitAppEvent(index: value)),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
