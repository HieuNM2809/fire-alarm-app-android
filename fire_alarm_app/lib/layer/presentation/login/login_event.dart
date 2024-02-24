import 'dart:async';
import 'dart:developer' as developer;

import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {
  Stream<LoginState> applyAsync({LoginState currentState, LoginBloc bloc});
}

class UnLoginEvent extends LoginEvent {
  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    yield UnLoginState();
  }
}

class LoadLoginEvent extends LoginEvent {
  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    try {
      yield InLoginState();
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorLoginState(_.toString());
    }
  }
}

class LoadLoginButtonEvent extends LoginEvent {
  @override
  Stream<LoginState> applyAsync(
      {LoginState? currentState, LoginBloc? bloc}) async* {
    try {
      yield InLoginButtonState();
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorLoginState(_.toString());
    }
  }
}
