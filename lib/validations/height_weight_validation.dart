import 'package:formz/formz.dart';

enum HeightandWeightError { empty, invalid }

class HeightandWeight extends FormzInput<String, HeightandWeightError> {
  const HeightandWeight.pure([String value = '']) : super.pure(value);
  const HeightandWeight.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^\d+(\.\d{1,3})?',
  );

  @override
  HeightandWeightError? validator(String value) {
    if (value.isEmpty == true || value == "") {
      return HeightandWeightError.empty;
    }
    return value.isNotEmpty == true && _nameRegExp.hasMatch(value)
        ? null
        : HeightandWeightError.invalid;
  }
}

extension Explanation on HeightandWeightError {
  String? get name {
    switch (this) {
      case HeightandWeightError.empty:
        return "Please Enter Name";
      case HeightandWeightError.invalid:
        return "This is not a valid name";
      default:
        return null;
    }
  }
}
