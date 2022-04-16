import 'package:formz/formz.dart';

enum WebsiteValidationError { invalid }

class Website extends FormzInput<String, WebsiteValidationError> {
  const Website.pure() : super.pure('');

  const Website.dirty([String value = '']) : super.dirty(value);

  static final RegExp _websiteRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  @override
  WebsiteValidationError? validator(String value) {
    return value.isEmpty
        ? null
        : _websiteRegExp.hasMatch(value)
            ? null
            : WebsiteValidationError.invalid;
  }
}

extension Explanation on WebsiteValidationError {
  String? get email {
    switch (this) {
      case WebsiteValidationError.invalid:
        return "Please Enter Valid Email Id.";
      default:
        return null;
    }
  }
}
