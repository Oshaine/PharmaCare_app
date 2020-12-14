import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacare_app/components/header.dart';
import 'package:pharmacare_app/components/payment_method.dart';
import 'package:pharmacare_app/models/Cart.dart';
import 'package:pharmacare_app/models/User.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var total = 0.0;
    var cartList = [];
    // ignore: unused_local_variable
    int medicationId, count;

    // ignore: unused_local_variable
    double price;

    getGrandTotal() {
      for (int i = 0; i < cart.length; i++) {
        // setState(() {
        total += cart[i].total;
        // });
      }
      print(total);
      return total;
    }

    var userId;
    User().getUserInfo().then((value) {
      userId = value['id'];
    });

    checkOut(paymentmethod, isPaid) async {
      try {
        for (int i = 0; i < cart.length; i++) {
          var tempList;
          tempList = {
            "medication_id": medicationId = cart[i].medication.id,
            "price_per_unit": price = cart[i].medication.pricePerUnit,
            "item_count": count = cart[i].numOfItems,
          };

          cartList.add(tempList);
        }

        var data = {
          'user_id': userId,
          "item_count": count,
          'grand_total': getGrandTotal().toStringAsFixed(2),
          'is_paid': isPaid,
          'payment_method': paymentmethod,
          'cart': cartList,
        };

        print(data);

        var endPoint = '/orders';
        var response = await Network().postRequest(data, endPoint);
        var body = json.decode(response.body);
        print(body);
        if (body['status_code'] == 200) {
          cart.clear();
          cartList.clear();
          Navigator.pushNamed(context, HomeScreen.routeName);

          Flushbar(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: Colors.green[200],
            message: "Order Has Been Placed",
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

    return SingleChildScrollView(
      child: Column(
        children: [
          Header(
              headerText: "Checkout",
              subText: "Choose your payment method below"),
          SizedBox(height: getProportationateScreenHeight(30)),
          Text(
            "Available Methods",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    FontAwesomeIcons.dollarSign,
                    color: Colors.indigo,
                  ),
                  title: Text(getGrandTotal().toStringAsFixed(2)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
