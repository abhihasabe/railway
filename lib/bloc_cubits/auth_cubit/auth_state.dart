import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String? message;
  final String? errorMessage;
  const AuthState({this.message, this.errorMessage});

  @override
  List<Object?> get props => [message, errorMessage];
}

// default state
class AuthInitialState extends AuthState {}

// login state
class AuthLoginLoading extends AuthState {
  const AuthLoginLoading();
}

class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess();
}

class AuthLoginFailure extends AuthState {
  const AuthLoginFailure();
}

// the logout

class AuthLogout extends AuthState {
  const AuthLogout();
}