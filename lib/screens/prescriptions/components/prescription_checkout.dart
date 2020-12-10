import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacare_app/components/header.dart';
import 'package:pharmacare_app/components/payment_method.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharmacare_app/screens/profile/profile_screen.dart';

class PrescriptionCheckoutScreen extends StatefulWidget {
  static String routeName = 'prescriptions-checkout';

  @override
  _PrescriptionCheckoutScreenState createState() =>
      _PrescriptionCheckoutScreenState();
}

class _PrescriptionCheckoutScreenState
    extends State<PrescriptionCheckoutScreen> {
  var prescription;
  var medicationId;
  var pricePerUnit;
  var quantity;

  @override
  void initState() {
    getUserPrescription();

    super.initState();
  }

  getUserPrescription() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userPrescription = localStorage.get('prescription');
    setState(() {
      prescription = json.decode(userPrescription);
    });
  }

  checkOut(paymentmethod, isPaid) async {
    try {
      var data = {
        'id': prescription['id'],
        'user_id': prescription['user_id'],
        'item_count': prescription['item_count'],
        'grand_total': prescription['grand_total'],
        'status': prescription['status'],
        'is_paid': isPaid,
        'payment_method': paymentmethod,
      };

      var endPoint =
          '/user-update-prescription/' + prescription['id'].toString();
      var response = await Network().putRequest(data, endPoint);
      var body = json.decode(response.body);
      if (body['status'] == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('prescription');
        Navigator.pushNamed(context, ProfileScreen.routeName);

        Flushbar(
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[200],
          message: "Payment Made",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } catch (e) {
      Flushbar(
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[200],
        message: "An Error Occured",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(prescription);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
                headerText: "Prescription Checkout",
                subText: "Choose your payment method below"),
            SizedBox(height: getProportationateScreenHeight(30)),
            Text(
              "Available Methods",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(height: getProportationateScreenHeight(30)),
            PaymentMethods(
              text: "Card",
              iconData: FontAwesomeIcons.creditCard,
              press: () {
                var paymentmethod = "Card";
                var isPaid = true;
                checkOut(paymentmethod, isPaid);
              },
            ),
            PaymentMethods(
              text: "PayPal",
              iconData: FontAwesomeIcons.paypal,
              press: () {
                var paymentmethod = "PayPal";
                bool isPaid = true;
                checkOut(paymentmethod, isPaid);
              },
            ),
            PaymentMethods(
              text: "Cash On Pickup",
              iconData: FontAwesomeIcons.moneyBill,
              press: () {
                var paymentmethod = "Cash On Pickup";
                bool isPaid = false;
                checkOut(paymentmethod, isPaid);
              },
            ),
            SizedBox(height: getProportationateScreenHeight(30)),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(getProportationateScreenWidth(20)),
                  child: ListTile(
                    trailing: Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.dollarSign,
                      color: Colors.indigo,
                    ),
                    title: Text(prescription['grand_total'].toString()),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
