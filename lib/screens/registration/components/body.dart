import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/header.dart';
import 'package:pharmacare_app/screens/registration/components/registration_form.dart';
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
              headerText: "Register Account",
              subText:
                  "Complete your registration to start \npurchasing our products",
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportationateScreenHeight(20)),
              child: RegistrationForm(),
            ),
            SizedBox(height: getProportationateScreenHeight(20)),
            Text(
              "By continuing you're confirming to our \nTerms and Conditions",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      // ),
    );
  }
}
