import 'package:rapid_response/theme/app_network_constants.dart';
import 'package:rapid_response/models/reg_req_model.dart';
import 'package:rapid_response/network/api_calls.dart';

class AuthRepository {
  dynamic resp;

  Future signInWithEmail(String userName, String password) async {
    var loginJson = {"email": userName, "password": password};
    resp = APIManager.authAPICall(LOGIN_URL, loginJson);
    return resp;
  }

  Future userRegistrationUser(RegReqModel employeeModel) {
    var regJson = {
      "name": "${employeeModel.name}" != "null" ? "${employeeModel.name}" : "",
      "email":
          "${employeeModel.email}" != "null" ? "${employeeModel.email}" : "",
      "phone":
          "${employeeModel.phone}" != "null" ? "${employeeModel.phone}" : "",
      "password": "${employeeModel.password}" != "null"
          ? "${employeeModel.password}"
          : "",
      "dept_id":
          "${employeeModel.deptId}" != "null" ? "${employeeModel.deptId}" : "",
      "user_type": "${employeeModel.userType}" != "null"
          ? "${employeeModel.userType}"
          : "",
      "activation": "${employeeModel.activation}" != "null"
          ? "${employeeModel.activation}"
          : ""
    };
    resp = APIManager.authAPICall(REG_URL, regJson);
    return resp;
  }

  Future fetchDeptTypeData() async {
    resp = APIManager.getAPICall(DEPT_URL);
    return resp;
  }
}
