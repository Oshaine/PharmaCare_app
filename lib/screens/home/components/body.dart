import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/api/api.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/home/components/categories.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/screens/home/components/icon_btn_counter.dart';
import 'package:pharmacare_app/screens/home/components/product_card.dart';
import 'package:pharmacare_app/screens/home/components/section_title.dart';
import 'package:pharmacare_app/screens/sign_in/sign_in_screen.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var userData;
  @override
  void initState() {
        Medication().getMedication();
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.get('user');
    var user = json.decode(userJson);

    setState(() {
      userData = user;
      // print(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(headerText: "PharmaCare"), //Header
            SizedBox(height: getProportationateScreenWidth(20)),
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportationateScreenWidth(20)),
                  child: Text(
                    'Hi',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportationateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportationateScreenWidth(10)),
                  child: Text(
                    userData != null
                        ? '${userData['first_name']} ${userData['last_name']}'
                        : '',
                    style:
                        TextStyle(fontSize: getProportationateScreenWidth(20)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportationateScreenWidth(20)),
                  child: IconBtnWithCounter(
                    svgSrc: "assets/icons/Log out.svg",
                    press: () {
                      logout(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportationateScreenWidth(20)),

            Categories(), //Categories List
            SizedBox(height: getProportationateScreenWidth(30)),
            // DiscountBanner(), //Discount Banner

            Column(
              children: [
                SectionTtile(
                  text: "Products",
                  press: () {},
                ),
                SizedBox(height: getProportationateScreenWidth(20)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        Medication.medications.length,
                        (index) => MedicationCard(
                          medication: Medication.medications[index],
                        ),
                      ),
                      SizedBox(
                        width: getProportationateScreenWidth(20),
                      )
                    ],
                  ),
                ),
                SizedBox(height: getProportationateScreenWidth(30)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void logout(BuildContext context) async {
  var endPoint = '/auth/logout';
  var response = await Network().getRequest(endPoint);
  var body = json.decode(response.body);
  if (body['status_code'] == 200) {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.popAndPushNamed(context, SignInScreen.routeName);
  }
}
