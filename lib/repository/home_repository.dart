import 'package:railway_alert/theme/app_network_constants.dart';
import 'package:railway_alert/network/api_calls.dart';

class HomeRepository {
  dynamic resp;

  Future fetchEmployeeData(String value) async {
    resp = APIManager.getAPICall("$GET_EMP_URL/${int.parse(value)}/2");
    return resp;
  }

  Future fetchEmployeeLocationData(int value) async {
    resp = APIManager.getAPICall("$GET_ADDRESS_URL/$value");
    return resp;
  }

  Future updateActivation(int userId) async {
    var jsonInput = {"activation": 1};
    resp = APIManager.updateAPICall("$UPDATE_EMP_URL/$userId}", jsonInput);
    return resp;
  }

  Future smsAPI(String smsURL) async {
    resp = APIManager.smsAPICall(smsURL);
    return resp;
  }

  Future getStationLocationById(value) async{
    resp = APIManager.getAPICall("$DEPT_ID_URL/$value");
    print("resp $resp");
    return resp;
  }
}
