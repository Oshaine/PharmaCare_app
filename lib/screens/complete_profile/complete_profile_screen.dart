import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/complete_profile/components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = '/complete_profile';

  final String email;
  final String password;

  const CompleteProfileScreen({Key key, this.email, this.password})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Complete Profile"),
          ),
      body: Body(),
    );
  }
}
