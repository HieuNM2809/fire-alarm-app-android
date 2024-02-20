import 'dart:async';
import 'dart:developer' as developer;

import 'package:fire_alarm_app/layer/presentation/user/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent {
  Stream<UserState> applyAsync({UserState currentState, UserBloc bloc});
}

class UnUserEvent extends UserEvent {
  @override
  Stream<UserState> applyAsync(
      {UserState? currentState, UserBloc? bloc}) async* {
    yield UnUserState();
  }
}

class LoadUserEvent extends UserEvent {
  @override
  Stream<UserState> applyAsync(
      {UserState? currentState, UserBloc? bloc}) async* {
    try {
      yield UnUserState();

      yield InUserState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorUserState(_.toString());
    }
  }
}
