import 'package:rapid_response/network/api_calls.dart';
import 'package:rapid_response/theme/app_network_constants.dart';

class ForgetPasswordRepository {
  dynamic resp;

  Future forgetPassword(String phone, String oldPassword, String newPassword) async {
    var updatePasswordJson = {
      "phone": phone,
      "oldPassword": oldPassword,
      "newPassword": newPassword
    };
    resp = APIManager.authAPICall(FORGET_PASSWORD_URL, updatePasswordJson);
    return resp;
  }
}
