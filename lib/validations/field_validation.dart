import 'package:formz/formz.dart';

enum FieldError { empty, invalid }

class Field extends FormzInput<String, FieldError> {
  const Field.pure([String value = '']) : super.pure(value);
  const Field.dirty([String value = '']) : super.dirty(value);

  @override
  FieldError? validator(String value) {
    if (value.isEmpty == true || value == "") {
      return FieldError.empty;
    }
    return value.isNotEmpty == true
        ? null
        : FieldError.invalid;
  }
}

extension Explanation on FieldError {
  String? get name {
    switch (this) {
      case FieldError.empty:
        return "Please Enter Name";
      case FieldError.invalid:
        return "This is not a valid name";
      default:
        return null;
    }
  }
}
