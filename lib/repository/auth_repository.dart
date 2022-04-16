import 'package:railway_alert/theme/app_network_constants.dart';
import 'package:railway_alert/models/reg_req_model.dart';
import 'package:railway_alert/network/api_calls.dart';

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
      "user_type": "${employeeModel.user_type}" != "null"
          ? "${employeeModel.user_type}"
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
