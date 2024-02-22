import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  RegisterState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnRegisterState extends RegisterState {
  UnRegisterState();

  @override
  String toString() => 'UnRegisterState';
}

/// Initialized
class InRegisterState extends RegisterState {
  InRegisterState(this.configIndex);

  final String configIndex;

  @override
  String toString() => 'InRegisterState $configIndex';

  @override
  List<Object> get props => [];
}

class ErrorRegisterState extends RegisterState {
  ErrorRegisterState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorRegisterState';

  @override
  List<Object> get props => [errorMessage];
}
