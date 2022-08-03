import 'package:rapid_response/theme/app_network_constants.dart';
import 'package:rapid_response/network/api_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class APIManager {
  static final APIManager _apiCall = APIManager._internal();
  static final encoding = Encoding.getByName('utf-8');
  static final headers = {'Content-Type': 'application/json'};

  factory APIManager() {
    return _apiCall;
  }

  static Future<dynamic> authAPICall(String basePath, Map param) async {
    var responseJson;
    final uri = Uri.parse(BASE_URL + basePath);
    final inputJSON = json.encode(param);
    try {
      await http
          .post(uri, headers: headers, body: inputJSON, encoding: encoding)
          .then((response) {
        responseJson = _response(response);
      }).catchError((onError) {
        print("onError " + onError.toString());
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> postAPICall(String basePath, Map param) async {
    var responseJson;
    final uri = Uri.parse(BASE_URL + basePath);
    final inputJSON = json.encode(param);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      await http
          .post(uri, headers: headers, body: inputJSON, encoding: encoding)
          .then((response) {
        responseJson = _response(response);
      }).catchError((onError) {
        print("onError " + onError.toString());
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> updateAPICall(String basePath, Map param) async {
    var responseJson;
    final uri = Uri.parse(BASE_URL + basePath);
    final inputJSON = json.encode(param);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      await http
          .patch(uri, headers: headers, body: inputJSON, encoding: encoding)
          .then((response) {
        responseJson = _response(response);
      }).catchError((onError) {
        print("onError " + onError.toString());
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> getAPICall(String basePath) async {
    var responseJson;
    var url = Uri.parse(BASE_URL + basePath);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      await http.get(url, headers: headers).then((response) {
        responseJson = _response(response);
      }).catchError((onError) {
        print("onError " + onError.toString());
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> smsAPICall(String basePath) async {
    var responseJson;
    var url = Uri.parse(basePath);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    try {
      await http.get(url, headers: headers).then((response) {
        responseJson = response;
      }).catchError((onError) {
        print("onError " + onError.toString());
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  APIManager._internal();
}
