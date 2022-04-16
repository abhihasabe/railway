//validate password
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

//return invalid if password does not match with expression
enum ConfirmPasswordValidationError { invalid, mismatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String? password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmPassword.dirty({this.password, String value = ''})
      : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.invalid;
    }
    return password == value ? null : ConfirmPasswordValidationError.mismatch;
  }
}

extension Explanation on ConfirmPasswordValidationError {
  String? get name {
    switch (this) {
      case ConfirmPasswordValidationError.mismatch:
        return 'passwords must match';
      default:
        return null;
    }
  }
}
