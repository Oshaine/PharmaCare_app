import 'dart:convert';

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
}
