import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/home/components/body.dart';
import 'package:pharmacare_app/screens/medications/medications_screen.dart';
import 'package:pharmacare_app/screens/profile/profile_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget _showPage = new Body();

  Widget _choosePage(page) {
    switch (page) {
      case 0:
        return new Body();
        break;
      case 1:
        return new ProfileScreen();
        break;
      case 2:
        return new MedicationsScreen();
        break;
      default:
        return new Container(child: Text('No Page Found!'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Complete Profile"),
        automaticallyImplyLeading: false,
      ),
      body: _showPage,
      bottomNavigationBar: CurvedNavigationBar(
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
            _showPage = _choosePage(index);
          });
        },
      ),
    );
  }
}
