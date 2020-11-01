import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/on_boarding/components/body.dart';
import 'package:pharmacare_app/size_config.dart';

class OnBoardingScreen extends StatelessWidget {
  static String routeName = "/boarding";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
