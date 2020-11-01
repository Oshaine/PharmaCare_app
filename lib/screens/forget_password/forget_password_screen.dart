import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/forget_password/components/body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forget_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Body(),
    );
  }
}
