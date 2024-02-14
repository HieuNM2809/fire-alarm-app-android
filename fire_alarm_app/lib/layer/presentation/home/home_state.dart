import 'package:equatable/equatable.dart';

import '../../data/model/user_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnHomeState extends HomeState {
  const UnHomeState();

  @override
  String toString() => 'UnHomeState';
}

/// Initialized
class InHomeState extends HomeState {
  const InHomeState(this.dataHomePage);

  final UserModel dataHomePage;

  @override
  String toString() => 'InHomeState $dataHomePage';

  @override
  List<Object> get props => [dataHomePage];
}

class ErrorHomeState extends HomeState {
  const ErrorHomeState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorHomeState';

  @override
  List<Object> get props => [errorMessage];
}
