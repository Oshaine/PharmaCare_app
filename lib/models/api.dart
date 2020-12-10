import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pharmacare_app/models/User.dart';
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
        'enctype': 'multipart/form-data',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Connection': 'keep-alive',
      };

//post reques to api
  postRequest(data, endPoint) async {
    var fullUrl = url + endPoint;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

//put request
  putRequest(data, endPoint) async {
    var fullUrl = url + endPoint;
    return await http.put(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  postImage(image, endPoint) async {
    var uri = Uri.parse(url + endPoint);
    var request = http.MultipartRequest('POST', uri);
    var userId;
    User().getUserInfo().then((value) {
      userId = value['id'];
    });
    request.fields['user_id'] = userId;
    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var response = await request.send();
    print(response.reasonPhrase);
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
