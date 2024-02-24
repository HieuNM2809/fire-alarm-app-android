import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';
import 'package:flutter/material.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitAppPage extends StatefulWidget {
  static const String routeName = '/initApp';

  const InitAppPage({super.key});

  @override
  InitAppPageState createState() => InitAppPageState();
}

class InitAppPageState extends State<InitAppPage> {
  final _initAppBloc = InitAppBloc(UnInitAppState());
  Widget? page1, page2;
  List<Widget> listWidget = [];
  int activeIndex = 0;

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
      bottomNavigationBar: BlocBuilder<InitAppBloc, InitAppState>(
        bloc: _initAppBloc,
        builder: (context, state) {
          if (state is InInitAppState) {
            activeIndex = state.index;
          }
          return BottomNavigationBar(
            unselectedLabelStyle:
                const TextStyle(color: Colors.white, fontSize: 14),
            fixedColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 255, 180, 59),
            currentIndex: activeIndex,
            elevation: 0,
            onTap: (value) =>
                _initAppBloc.add(ChangePageInitAppEvent(index: value)),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                icon: Icon(Icons.person),
                label: 'Business',
              ),
            ],
          );
        },
      ),
    );
  }
}
