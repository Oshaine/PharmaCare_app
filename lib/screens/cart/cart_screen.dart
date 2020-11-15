import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Cart.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/cart/components/body.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text("${cart.length} Items",
              style: Theme.of(context).textTheme.caption)
        ],
      ),
    );
  }
}

class CheckOutCard extends StatefulWidget {
  const CheckOutCard({
    Key key,
  }) : super(key: key);

  @override
  _CheckOutCardState createState() => _CheckOutCardState();
}

class _CheckOutCardState extends State<CheckOutCard> {
  // Cart cart;
  var total = 0.0;
  int userId;
  String paymentMethod;
  int medicationId;
  double price;
  int count;
  @override
  void initState() {
    getGrandTotal();
    super.initState();
  }

  getGrandTotal() {
    for (int i = 0; i < cart.length; i++) {
      setState(() {
        if (cart[i].total != null) {
          total += cart[i].total;
        } else {
          total += cart[i].medication.pricePerUnit * cart[i].numOfItems;
        }
      });
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.get('user');
    var user = json.decode(userJson);

    setState(() {
      userId = user['id'];
      // print(userData);
    });
  }

  checkOut() async {
     try {
    var cartList = [];

    _getUserInfo();
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
      'grand_total': total,
      'payment_method': 'paypal',
      'cart': cartList,
    };
   
      var endPoint = '/orders';
      var response = await Network().postRequest(data, endPoint);
      var body = json.decode(response.body);
      if (body['status_code'] == 200) {
        cart.clear();
        Flushbar(
          message: body['message'],
          duration: Duration(seconds: 3),
        )..show(context);

        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } catch (e) {
      Flushbar(
        message: "Something happened, Try again later",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportationateScreenHeight(15),
          horizontal: getProportationateScreenWidth(30)),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    height: getProportationateScreenHeight(40),
                    width: getProportationateScreenHeight(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg",
                        color: kPrimaryColor)),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward_ios, size: 12, color: kTextColor),
              ],
            ),
            SizedBox(height: getProportationateScreenWidth(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Toatal:\n",
                    children: [
                      TextSpan(
                          text: "\$ " + total.toStringAsFixed(2),
                          style: TextStyle(fontSize: 16, color: Colors.black))
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportationateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      checkOut();
                    },
                  ),
                ),
                SizedBox(
                  height: getProportationateScreenWidth(20),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
