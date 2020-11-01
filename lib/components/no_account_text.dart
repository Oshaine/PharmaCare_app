import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/registration/registration_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: getProportationateScreenWidth(12)),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.popAndPushNamed(context, RegistrationScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportationateScreenWidth(12),
                color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
