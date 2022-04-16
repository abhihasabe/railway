import 'package:formz/formz.dart';

enum NameError { empty, invalid }

class Name extends FormzInput<String, NameError> {
  const Name.pure([String value = '']) : super.pure(value);

  const Name.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^(?=.*[a-z])[A-Za-z ]{2,}$',
  );

  @override
  NameError? validator(String value) {
    if (value.isEmpty == true || value == "" || value.length<=5) {
      return NameError.empty;
    }
    return value.isNotEmpty == true && _nameRegExp.hasMatch(value)
        ? null
        : NameError.invalid;
  }
}

extension Explanation on NameError {
  String? get name {
    switch (this) {
      case NameError.empty:
        return "Please Enter Name";
      case NameError.invalid:
        return "This is not a valid name";
      default:
        return null;
    }
  }
}
