import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/screens/orders/orders_screen.dart';
import 'package:pharmacare_app/screens/profile/profile_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key key,
    @required this.routeName,
  }) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
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
        switch (index) {
          case 0:
            Navigator.popAndPushNamed(context, HomeScreen.routeName);
            break;
          case 1:
            Navigator.popAndPushNamed(context, ProfileScreen.routeName);
            break;
          case 2:
            Navigator.popAndPushNamed(context, OrdersScreen.routeName);
            break;
        }
      },
    );
  }
}
