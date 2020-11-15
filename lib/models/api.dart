import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  //api url
  final String url = 'http://10.0.2.2:8000/api';
  //server path
  final String serverPath = 'http://10.0.2.2:8000/';
  var token;

  _getToken() async {
    //create new instance of shared preference and access user 'access token'
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

//set header and specify content type
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Connection': 'Keep-Alive',
      };

//post reques to api
  postRequest(data, endPoint) async {
    var fullUrl = url + endPoint;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getRequest(endPoint) async {
    var fullUrl = url + endPoint;
    await _getToken();
    //return data from api
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }
}
