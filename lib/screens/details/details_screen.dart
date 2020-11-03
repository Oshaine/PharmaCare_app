import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details';
  @override
  Widget build(BuildContext context) {
    final MedicationDetailsArgs arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(),
      body: Body(
        medication: arguments.medication,
      ),
    );
  }
}

class MedicationDetailsArgs {
  final Medication medication;

  MedicationDetailsArgs({@required this.medication});
}
