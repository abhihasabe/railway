import 'package:railway_alert/models/add_address_req_model.dart';
import 'package:railway_alert/network/api_calls.dart';
import 'package:railway_alert/theme/app_network_constants.dart';

class AddressRepository {
  dynamic resp;

  Future addressData(AddAddressReq addressResp) async {
    print("addressRespa $addressResp");
    var addressJson = {
      "latitude": addressResp.latitude,
      "longitude": addressResp.longitude,
      "time": addressResp.time,
      "eId": addressResp.eId
    };
    resp = APIManager.postAPICall(ADD_ADDRESS_URL, addressJson);
    return resp;
  }
}
