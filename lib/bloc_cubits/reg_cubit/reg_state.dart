import 'package:railway_alert/validations/confirm_password_validation.dart';
import 'package:railway_alert/validations/dob_validation.dart';
import 'package:railway_alert/validations/field_validation.dart';
import 'package:railway_alert/validations/number_validation_dart.dart';
import 'package:railway_alert/validations/password_validation.dart';
import 'package:railway_alert/validations/email_validation.dart';
import 'package:railway_alert/validations/name_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class RegState extends Equatable {
  const RegState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.dob = const DOB.pure(),
    this.location = const Field.pure(),
    this.userType = const Field.pure(),
    this.dept = const Field.pure(),
    this.number = const Number.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError = "",
  });

  final Email email;
  final Name name;
  final Number number;
  final DOB dob;
  final Field location;
  final Field userType;
  final Field dept;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props => [
        email,
        name,
        password,
        dob,
        location,
        userType,
        dept,
        number,
        confirmPassword,
        status,
        exceptionError
      ];

  RegState copyWith({
    Email? email,
    Name? name,
    Password? password,
    DOB? dob,
    Field? location,
    Field? userType,
    Field? dept,
    Number? number,
    ConfirmPassword? confirmPassword,
    FormzStatus? status,
    String? exceptionError,
  }) {
    return RegState(
      name: name ?? this.name,
      dob: dob ?? this.dob,
      location: location ?? this.location,
      userType: userType ?? this.userType,
      email: email ?? this.email,
      dept: dept ?? this.dept,
      number: number ?? this.number,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
