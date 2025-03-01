import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tokokita/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    print('API (token):${token}');

    var responseJson;
    try {
      final response = await http.post
      (Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token", "Content-Type" : "application/json",
        },
      );
    responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }catch (e) {
      print('Error in POST request: $e');
      throw Exception('Failer to perform POST request');
    }
    return responseJson;
  }

  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await 
      http.post(Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
    responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } 
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      return response;
      case 400:
      throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      throw UnauthorisedException(response.body.toString());
      case 422:
      throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode ${response.statusCode}');
    }
  }

}