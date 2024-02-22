import 'dart:async';
import 'dart:developer' as developer;

import 'package:fire_alarm_app/layer/presentation/register/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent {
  Stream<RegisterState> applyAsync(
      {RegisterState currentState, RegisterBloc bloc});
}

class UnRegisterEvent extends RegisterEvent {
  @override
  Stream<RegisterState> applyAsync(
      {RegisterState? currentState, RegisterBloc? bloc}) async* {
    yield UnRegisterState();
  }
}

class LoadRegisterEvent extends RegisterEvent {
  final String configIndex;

  LoadRegisterEvent({required this.configIndex});
  @override
  Stream<RegisterState> applyAsync(
      {RegisterState? currentState, RegisterBloc? bloc}) async* {
    try {
      yield UnRegisterState();
      yield InRegisterState(configIndex);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRegisterEvent', error: _, stackTrace: stackTrace);
      yield ErrorRegisterState(_.toString());
    }
  }
}
