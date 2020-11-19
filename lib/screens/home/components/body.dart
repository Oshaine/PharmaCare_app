import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/models/User.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/details/details_screen.dart';
import 'package:pharmacare_app/screens/home/components/categories.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/screens/home/components/icon_btn_counter.dart';
import 'package:pharmacare_app/screens/home/components/medication_card.dart';
import 'package:pharmacare_app/screens/home/components/section_title.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var userData;
  @override
  void initState() {
    getMedication();
    User().getUserInfo().then((value) {
      setState(() {
        userData = value;
      });
    });
    super.initState();
  }

  //get Medications
  List<Medication> medications = [];

  void getMedication() async {
    var endPoint = '/medications';
    var response = await Network().getRequest(endPoint);
    var body = json.decode(response.body);
    for (var item in body['data']) {
      // print(item.name);
      //pass question to constructor
      Medication medication = Medication.fromJson(item);
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
                      User().logout(context);
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
            SizedBox(height: getProportationateScreenWidth(10)),

            Categories(), //Categories List
            SizedBox(height: getProportationateScreenWidth(20)),
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
                      //view single medication details

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
}
