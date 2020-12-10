import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/medications/components/body.dart';

class MedicationsScreen extends StatelessWidget {
  static String routeName = '/medications';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Body(),
    );
  }
}
