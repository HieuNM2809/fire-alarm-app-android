import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';

class InitAppScreen extends StatefulWidget {
  const InitAppScreen({
    Key? key,
    required InitAppBloc initAppBloc,
    required this.widgetChild,
  })  : _initAppBloc = initAppBloc,
        super(key: key);

  final InitAppBloc _initAppBloc;
  final List<Widget> widgetChild;
  @override
  InitAppScreenState createState() {
    return InitAppScreenState();
  }
}

class InitAppScreenState extends State<InitAppScreen> {
  InitAppScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitAppBloc, InitAppState>(
        bloc: widget._initAppBloc,
        builder: (
          BuildContext context,
          InitAppState currentState,
        ) {
          if (currentState is UnInitAppState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorInitAppState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text('reload'),
                ),
              ],
            ));
          }
          if (currentState is InInitAppState) {
            return widget.widgetChild[currentState.index];
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
