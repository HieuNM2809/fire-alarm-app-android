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
  InRegisterState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InRegisterState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorRegisterState extends RegisterState {
  ErrorRegisterState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorRegisterState';

  @override
  List<Object> get props => [errorMessage];
}
