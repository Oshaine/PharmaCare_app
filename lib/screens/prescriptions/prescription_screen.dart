import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/prescriptions/components/body.dart';

class PrescriptionScreen extends StatelessWidget {
  static String routeName = 'prescriptions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescriptions"),
      ),
      body: Body(),
    );
  }
}
