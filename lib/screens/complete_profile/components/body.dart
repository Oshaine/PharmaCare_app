import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/header.dart';
import 'package:pharmacare_app/screens/complete_profile/components/complete_profile_form.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              headerText: "Complete Registration",
              subText: "Last step to setup your account",
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportationateScreenHeight(20)),
              child: CompleteProfileForm(),
            ),
            SizedBox(height: getProportationateScreenHeight(30)),
            Text(
              "By continuing you're confirming to our \nTerms and Conditions",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
