import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/home/components/body.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pharmacare_app/size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Complete Profile"),
          ),
      body: Body(),
      bottomNavigationBar: CurvedNavigationBar(
        height: getProportationateScreenHeight(50),
        backgroundColor: Colors.white,
        color: kPrimaryColor,
        items: <Widget>[
          Icon(Icons.home_outlined,
              size: getProportationateScreenWidth(30), color: Colors.white),
          Icon(Icons.account_circle_rounded,
              size: getProportationateScreenWidth(30), color: Colors.white),
          Icon(Icons.receipt_long,
              size: getProportationateScreenWidth(30), color: Colors.white),
        ],
        onTap: (index) {
          PageController(initialPage: index);
        },
      ),
    );
  }
}
