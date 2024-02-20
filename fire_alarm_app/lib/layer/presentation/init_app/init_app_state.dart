import 'package:equatable/equatable.dart';

abstract class InitAppState extends Equatable {
  InitAppState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnInitAppState extends InitAppState {
  UnInitAppState();

  @override
  String toString() => 'UnInitAppState';
}

/// Initialized
class InInitAppState extends InitAppState {
  InInitAppState(this.index);

  final int index;

  @override
  String toString() => 'InInitAppState $index';

  @override
  List<Object> get props => [];
}

class ErrorInitAppState extends InitAppState {
  ErrorInitAppState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorInitAppState';

  @override
  List<Object> get props => [errorMessage];
}
