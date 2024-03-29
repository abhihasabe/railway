import 'package:rapid_response/validations/confirm_password_validation.dart';
import 'package:rapid_response/validations/dob_validation.dart';
import 'package:rapid_response/validations/field_validation.dart';
import 'package:rapid_response/validations/number_validation_dart.dart';
import 'package:rapid_response/validations/password_validation.dart';
import 'package:rapid_response/validations/email_validation.dart';
import 'package:rapid_response/validations/name_validation.dart';
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
    this.railway = const Field.pure(),
    this.zone = const Field.pure(),
    this.division = const Field.pure(),
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
  final Field railway;
  final Field zone;
  final Field division;
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
        railway,
        zone,
        division,
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
    Field? railway,
    Field? zone,
    Field? division,
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
      railway: railway ?? this.railway,
      zone: zone ?? this.zone,
      division: division ?? this.division,
      dept: dept ?? this.dept,
      number: number ?? this.number,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
