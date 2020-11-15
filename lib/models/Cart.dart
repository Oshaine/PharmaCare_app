import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/Medication.dart';

class Cart {
  final Medication medication;
  int numOfItems;
  double total;

  Cart({
    @required this.medication,
    @required this.numOfItems,
  });
}

List<Cart> cart = [];
