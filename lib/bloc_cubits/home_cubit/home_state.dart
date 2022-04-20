import 'package:equatable/equatable.dart';
import 'package:railway_alert/models/address_resp_model.dart';
import 'package:railway_alert/models/emp_resp_model.dart';

abstract class HomeState extends Equatable {
  final String? message;
  final String? errorMessage;

  const HomeState({this.message, this.errorMessage});

  @override
  List<Object?> get props => [message, errorMessage];
}

// default state
class HomeInitialState extends HomeState {}

// login state
class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final String? message;
  final List<EmpData>? countData;

  const HomeSuccess({this.message, this.countData});

  @override
  List<Object?> get props => [message, countData];
}

class HomeDetailSuccess extends HomeState {
  final String? message;
  final List<AddressData>? countData;

  const HomeDetailSuccess({this.message, this.countData});

  @override
  List<Object?> get props => [message, countData];
}

class HomeFailure extends HomeState {
  final String? errorMessage;

  const HomeFailure({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
