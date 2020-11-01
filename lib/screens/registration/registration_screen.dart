import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/registration/components/body.dart';

class RegistrationScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Sign Up"),
          ),
      body: Body(),
    );
  }
}
