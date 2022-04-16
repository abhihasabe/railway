import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return value.isNotEmpty == true && value.length >= 5
        ? null
        : PasswordValidationError.invalid;
  }
}

extension Explanation on PasswordValidationError {
  String? get name {
    switch (this) {
      case PasswordValidationError.empty:
        return "Please add Password!";
      case PasswordValidationError.invalid:
        return "Please add valid Password!";
      default:
        return null;
    }
  }
}
