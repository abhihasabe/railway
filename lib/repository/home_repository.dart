import 'package:railway_alert/theme/app_network_constants.dart';
import 'package:railway_alert/network/api_calls.dart';

class HomeRepository {
  dynamic resp;

  Future fetchEmployeeData(int value) async {
    resp = APIManager.getAPICall(GET_EMP_URL + "${value / 1}");
    return resp;
  }
}
