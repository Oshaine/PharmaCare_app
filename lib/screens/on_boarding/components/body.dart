import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/on_boarding/components/on_boarding_content.dart';
import 'package:pharmacare_app/screens/sign_in/sign_in_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> onBoardingData = [
    {
      "text": "Welcome to PharmaCare, The Pharmacy that Cares!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text":
          "Welcome to PharmaCare, The Pharmacy that Cares! \n for the people in Jamaica",
      "image": "assets/images/splash_2.png",
    },
    {
      "text":
          "Welcome to PharmaCare, The Pharmacy that Cares! \n Come and get your supplies today",
      "image": "assets/images/splash_3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardingData.length,
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: onBoardingData[index]["image"],
                    text: onBoardingData[index]["text"],
                  ),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportationateScreenWidth(20)),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          onBoardingData.length, (index) => buildDot(index)),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.popAndPushNamed(
                            context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
