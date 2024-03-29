import 'package:rapid_response/validations/email_validation.dart';
import 'package:rapid_response/validations/number_validation_dart.dart';
import 'package:rapid_response/validations/password_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  const LoginState({
    this.number = const Number.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final Number number;
  final Password password;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props => [number, password, status, exceptionError];

  LoginState copyWith({
    Number? number,
    Password? password,
    FormzStatus? status,
    String? exceptionError,
  }) {
    return LoginState(
      number: number ?? this.number,
      password: password ?? this.password,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
