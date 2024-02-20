import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc(UserState initialState) : super(initialState){
   on<UserEvent>((event, emit) {
      return emit.forEach<UserState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'UserBloc', error: error, stackTrace: stackTrace);
          return ErrorUserState(error.toString());
        },
      );
    });
  }
}
