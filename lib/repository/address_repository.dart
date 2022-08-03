import 'package:rapid_response/models/add_address_req_model.dart';
import 'package:rapid_response/network/api_calls.dart';
import 'package:rapid_response/theme/app_network_constants.dart';

class AddressRepository {
  dynamic resp;

  Future addressData(AddAddressReq addressResp) async {
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
