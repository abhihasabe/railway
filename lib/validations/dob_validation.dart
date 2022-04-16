import 'package:formz/formz.dart';

enum DOBError { empty, invalid }

class DOB extends FormzInput<String, DOBError> {
  const DOB.pure([String value = '']) : super.pure(value);
  const DOB.dirty([String value = '']) : super.dirty(value);

  @override
  DOBError? validator(String value) {
    if (value.isEmpty == true || value == "") {
      return DOBError.empty;
    }
    return value.isNotEmpty == true
        ? null
        : value.isEmpty
            ? null
            : DOBError.invalid;
  }
}

extension Explanation on DOBError {
  String? get name {
    switch (this) {
      case DOBError.empty:
        return "Please Enter DOB";
      case DOBError.invalid:
        return "This is not a valid DOB";
      default:
        return null;
    }
  }
}
