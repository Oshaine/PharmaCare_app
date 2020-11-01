import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/header.dart';
import 'package:pharmacare_app/components/no_account_text.dart';
import 'package:pharmacare_app/components/social_card.dart';
import 'package:pharmacare_app/screens/sign_in/components/sign_form.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.2,
              child: Header(
                headerText: "Welcome",
                subText:
                    "Sign in with your email and password \nor continue with social media",
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportationateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        SignForm(),
                        SizedBox(height: SizeConfig.screenHeight * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialCard(
                              icon: "assets/icons/google-icon.svg",
                              press: () {},
                            ),
                            SocialCard(
                              icon: "assets/icons/facebook-2.svg",
                              press: () {},
                            ),
                            SocialCard(
                              icon: "assets/icons/twitter.svg",
                              press: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: getProportationateScreenHeight(20)),
                        NoAccountText(),
                        SizedBox(height: getProportationateScreenHeight(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
