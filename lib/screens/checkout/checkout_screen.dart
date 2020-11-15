import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/checkout/components/body.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Complete Profile"),
          ),
      body: Body(),
    );
  }
}
