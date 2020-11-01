import 'dart:convert';
import 'package:pharmacare_app/api/api.dart';
import 'package:flutter/material.dart';

class Medication {
  final int id;
  final String name, type, route, strength, usage, dosage;
  final int categoryId, units;
  final List<String> images;
  final double pricePerUnit;
  final bool isFavourite, isPopular;

  Medication(
      {this.id,
       this.name,
       this.type,
       this.route,
       this.strength,
       this.usage,
       this.dosage,
       this.categoryId,
       this.units,
       this.images,
       this.pricePerUnit,
       this.isFavourite,
      this.isPopular});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        route: json['route'],
        strength: json['strength'],
        usage: json['usage'],
        dosage: json['dosage'],
        categoryId: json['categoryId'],
        units: json['units'],
        images: json['images'],
        pricePerUnit: json['pricePerUnit'],
        isFavourite: json['isFavourite'],
        isPopular: json['isPopular']);
  }

  //get Medications
  static List<Medication> medications = [];

  void getMedication() async {
    var endPoint = '/medications';
    var response = await Network().getRequest(endPoint);
    var body = json.decode(response.body);
    for (var item in body['data']) {
      //pass question to constructor
      Medication medication = Medication.fromJson(item);
      medications.add(medication);
    }
  }
}
