import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var isLoggedIn = false;
  void startTimer() {
    Timer(Duration(seconds: 10), () {
      _checkIfLoggedIn();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Shimmer.fromColors(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    Text(
                      "PharmaCare",
                      style: TextStyle(fontSize: 50.0, shadows: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 5.0,
                          blurRadius: 2.0,
                        ),
                      ]),
                    ),
                    SizedBox(height: 50),
                    // Loader(),
                  ],
                ),
              ),
              baseColor: Color(0xFF193566),
              highlightColor: Color(0xFFD90368),
            ),
          ],
        ),
      ),
    );
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isLoggedIn = true;
        Navigator.pushNamed(context, HomeScreen.routeName);
      });
    } else {
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }
}
