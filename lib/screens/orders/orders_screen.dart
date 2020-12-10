import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/orders/components/body.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Body(),
      backgroundColor:
          Color.alphaBlend(Colors.lightBlueAccent.shade100, kPrimaryColor),
    );
  }
}
