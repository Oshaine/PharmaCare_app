import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/home/components/body.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/screens/medications/medications_screen.dart';
import 'package:pharmacare_app/screens/profile/profile_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation(
      {Key key,
      // @required this.pages,
      @required this.routeName})
      : super(key: key);

  final String routeName;
  // final List<Widget> pages;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget showPage = Body();

  Widget _choosePage(page) {
    switch (page) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return ProfileScreen();
        break;
      case 2:
        return MedicationsScreen();
        break;
      default:
        return new Container(child: Text('No Page Found!'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _pageIndex,
      key: _bottomNavigationKey,
      height: getProportationateScreenHeight(50),
      backgroundColor: Colors.transparent,
      color: kPrimaryColor,
      items: <Widget>[
        Icon(Icons.home_outlined,
            size: getProportationateScreenWidth(30), color: Colors.white),
        Icon(Icons.account_circle_rounded,
            size: getProportationateScreenWidth(30), color: Colors.white),
        Icon(Icons.medical_services,
            size: getProportationateScreenWidth(30), color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          showPage = _choosePage(index);
        });
      },
    );
  }
}
