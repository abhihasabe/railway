import 'package:rapid_response/theme/app_network_constants.dart';
import 'package:rapid_response/models/reg_req_model.dart';
import 'package:rapid_response/network/api_calls.dart';

class AuthRepository {
  dynamic resp;

  Future signInWithEmail(String userName, String password) async {
    var loginJson = {"phone": userName, "password": password};
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

  Future fetchRailwayData() async {
    resp = APIManager.getAPICall(RAILWAY_URL);
    return resp;
  }

  Future fetchZoneData(selectedId) async {
    resp = APIManager.getAPICall(ZONE_URL + "$selectedId");
    return resp;
  }

  Future fetchDivisionData(selectedId) async {
    resp = APIManager.getAPICall(DIVISION_URL + "$selectedId");
    return resp;
  }

  Future fetchDeptTypeData(selectedId) async {
    resp = APIManager.getAPICall(DEPT_URL + "$selectedId");
    return resp;
  }
}
