import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecStore {
  static const _storage = FlutterSecureStorage();
  SecStore._();

  static Future getValue({required String keyVal}) async {
    var val = await _storage.read(key: keyVal);
    return val;
  }

  static getAllValues() async {
    var allValues = await _storage.readAll();
    var setVal = allValues.isEmpty ? null : allValues;
    return setVal;
  }

  static deleteValue({required String keyVal}) async {
    await _storage.delete(key: keyVal);
  }

  static deleteAll() async {
    var value = await _storage.deleteAll();
    return value;
  }

  static Future setValue({required String keyVal, required String value}) async {
    await _storage.write(key: keyVal, value: value);
  }

  static Future<bool> contains(String valKey) async {
    bool keyV = await _storage.containsKey(key: valKey);
    return keyV;
  }
}
