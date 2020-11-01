import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
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
