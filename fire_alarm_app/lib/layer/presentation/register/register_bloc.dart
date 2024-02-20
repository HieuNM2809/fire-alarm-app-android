import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:fire_alarm_app/layer/presentation/register/index.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  RegisterBloc(RegisterState initialState) : super(initialState){
   on<RegisterEvent>((event, emit) {
      return emit.forEach<RegisterState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'RegisterBloc', error: error, stackTrace: stackTrace);
          return ErrorRegisterState(error.toString());
        },
      );
    });
  }
}
