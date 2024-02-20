import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  UserState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnUserState extends UserState {

  UnUserState();

  @override
  String toString() => 'UnUserState';
}

/// Initialized
class InUserState extends UserState {
  InUserState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InUserState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorUserState extends UserState {
  ErrorUserState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorUserState';

  @override
  List<Object> get props => [errorMessage];
}
