import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnLoginState extends LoginState {
  UnLoginState();

  @override
  String toString() => 'UnLoginState';
}

/// Initialized
class InLoginState extends LoginState {
  @override
  String toString() => 'InLoginState ';

  @override
  List<Object> get props => [];
}

class InLoginButtonState extends LoginState {
  InLoginButtonState();
}

class ErrorLoginState extends LoginState {
  ErrorLoginState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorLoginState';

  @override
  List<Object> get props => [errorMessage];
}
