import 'package:formz/formz.dart';

//create enum

enum PincodeValidationError { invalid }

//create class to validate email address

class Pincode extends FormzInput<String, PincodeValidationError> {
  const Pincode.pure([String value = '']) : super.pure(value);

  const Pincode.dirty([String value = '']) : super.dirty(value);

  static final RegExp _pincodeRegExp =
      RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false);

  @override
  PincodeValidationError? validator(String value) {
    return _pincodeRegExp.hasMatch(value)
        ? null
        : value.isNotEmpty == true
            ? null
            : PincodeValidationError.invalid;
  }
}

extension Explanation on PincodeValidationError {
  String? get email {
    switch (this) {
      case PincodeValidationError.invalid:
        return "Please enter valid mobile number";
      default:
        return null;
    }
  }
}
