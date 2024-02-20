import 'dart:async';
import 'dart:developer' as developer;

import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InitAppEvent {
  Stream<InitAppState> applyAsync(
      {InitAppState currentState, InitAppBloc bloc});
}

class UnInitAppEvent extends InitAppEvent {
  @override
  Stream<InitAppState> applyAsync(
      {InitAppState? currentState, InitAppBloc? bloc}) async* {
    yield UnInitAppState();
  }
}

class ChangePageInitAppEvent extends InitAppEvent {
  final int index;

  ChangePageInitAppEvent({required this.index});
  @override
  Stream<InitAppState> applyAsync(
      {InitAppState? currentState, InitAppBloc? bloc}) async* {
    try {
      yield UnInitAppState();

      yield InInitAppState(index);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadInitAppEvent', error: _, stackTrace: stackTrace);
      yield ErrorInitAppState(_.toString());
    }
  }
}
