import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionHelper {
  static ConnectivityResult? _connectivityResult;

  static Future _connect() async {
    _connectivityResult = await Connectivity().checkConnectivity();
  }

  static Future<bool> hasConnection() async {
    await _connect();
    if (_connectivityResult == ConnectivityResult.mobile) return true;
    if (_connectivityResult == ConnectivityResult.wifi) return true;
    if (_connectivityResult == ConnectivityResult.none) return false;
    return false;
  }

  static Stream<ConnectivityResult> connectionListener() {
    return Connectivity().onConnectivityChanged;
  }
}
