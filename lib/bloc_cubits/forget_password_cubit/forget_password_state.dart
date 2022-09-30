import 'package:rapid_response/validations/email_validation.dart';
import 'package:rapid_response/validations/number_validation_dart.dart';
import 'package:rapid_response/validations/password_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.number = const Number.pure(),
    this.nPassword = const Password.pure(),
    this.nsPassword = const Password.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final Number number;
  final Password nPassword;
  final Password nsPassword;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props =>
      [number, nPassword, nsPassword, status, exceptionError];

  ForgetPasswordState copyWith({
    Number? number,
    Password? nPassword,
    Password? nsPassword,
    FormzStatus? status,
    String? exceptionError,
  }) {
    return ForgetPasswordState(
      number: number ?? this.number,
      nPassword: nPassword ?? this.nPassword,
      nsPassword: nsPassword ?? this.nsPassword,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
