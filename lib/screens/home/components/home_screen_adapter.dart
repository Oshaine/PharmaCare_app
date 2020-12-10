import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/home/components/search_results.dart';

abstract class IHomeScreenAdapter {
  void onSearchQuery(BuildContext context, String query);
}

class HomeScreenAdpater implements IHomeScreenAdapter {
  final Medication _medication;

  HomeScreenAdpater(this._medication);
  @override
  void onSearchQuery(BuildContext context, String query) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SearchResults(query),
        ));
  }
}
