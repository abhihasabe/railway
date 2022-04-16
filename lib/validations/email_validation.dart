import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : _emailRegExp.hasMatch(value)
            ? null
            : EmailValidationError.invalid;
  }
}

extension Explanation on EmailValidationError {
  String? get email {
    switch (this) {
      case EmailValidationError.invalid:
        return "Please Enter Valid Email Id.";
      default:
        return null;
    }
  }
}
