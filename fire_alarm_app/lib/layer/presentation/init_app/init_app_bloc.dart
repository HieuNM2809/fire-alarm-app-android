import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';

class InitAppBloc extends Bloc<InitAppEvent, InitAppState> {

  InitAppBloc(InitAppState initialState) : super(initialState){
   on<InitAppEvent>((event, emit) {
      return emit.forEach<InitAppState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'InitAppBloc', error: error, stackTrace: stackTrace);
          return ErrorInitAppState(error.toString());
        },
      );
    });
  }
}
