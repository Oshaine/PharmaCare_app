import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/api/api.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/details/details_screen.dart';
import 'package:pharmacare_app/screens/home/components/categories.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/screens/home/components/icon_btn_counter.dart';
import 'package:pharmacare_app/screens/home/components/medication_card.dart';
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
    getMedication();
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

  //get Medications
  List<Medication> medications = [];

  void getMedication() async {
    var endPoint = '/medications';
    var response = await Network().getRequest(endPoint);
    var body = json.decode(response.body);
    for (var item in body['data']) {
      //pass question to constructor
      Medication medication = Medication.fromJson(item);
      // print(item);
      setState(() {
        medications.add(medication);
      });
    }
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
                    'Welcome,',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportationateScreenWidth(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportationateScreenWidth(5)),
                  child: Text(
                    userData != null
                        ? '${userData['first_name']} ${userData['last_name']}'
                        : '',
                    style:
                        TextStyle(fontSize: getProportationateScreenWidth(14)),
                  ),
                ),
                Spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(right: getProportationateScreenWidth(20)),
                  child: IconBtnWithCounter(
                    svgSrc: "assets/icons/Log out.svg",
                    press: () {
                      logout();
                    },
                  ),
                ),
              ],
            ),
            Divider(
              height: getProportationateScreenHeight(30),
              endIndent: 25,
              indent: 25,
              thickness: 0.5,
              color: kPrimaryLightColor,
            ),
            SizedBox(height: getProportationateScreenWidth(20)),

            Categories(), //Categories List
            SizedBox(height: getProportationateScreenWidth(30)),
            // DiscountBanner(), //Discount Banner

            Column(
              children: [
                SectionTtile(
                  text: "Featured Medications",
                  press: () {},
                ),
                SizedBox(height: getProportationateScreenWidth(20)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        medications.length,
                        (index) => MedicationCard(
                          press: () => Navigator.pushNamed(
                              context, DetailsScreen.routeName,
                              arguments: MedicationDetailsArgs(
                                  medication: medications[index])),
                          medication: medications[index],
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

  void logout() async {
    var endPoint = '/auth/logout';
    var response = await Network().getRequest(endPoint);
    var body = json.decode(response.body);
    if (body['status_code'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      print("user logged out");
      Navigator.popAndPushNamed(context, SignInScreen.routeName);
    }
  }
}
