import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  //get User Signed Data
  getUserInfo() async {
    var userData;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.get('user');
    var user = json.decode(userJson);

    userData = user;

    // print(this.userId);
    return userData;
  }

  logout(BuildContext context) async {
    var endPoint = '/auth/logout';
    var response = await Network().getRequest(endPoint);
    var body = json.decode(response.body);
    if (body['status_code'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      print("user logged out");
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }

  getUserPrescriptions(user) async {
    var endPoint = '/user-prescriptions';
    var response = await Network().postRequest(user, endPoint);
    List<dynamic> body = json.decode(response.body);
    return body;
  }

  getUserOrders(user) async {
    var endPoint = '/user-orders';
    var response = await Network().postRequest(user, endPoint);
    List<dynamic> body = json.decode(response.body);
    return body;
  }
}
