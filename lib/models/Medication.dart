import 'dart:convert';

import 'package:pharmacare_app/models/api.dart';

class Medication {
  final int id;
  final String name, type, route, strength, usage, image, dosage;
  final int categoryId, units;
  final double pricePerUnit;
  final int isFavourite, isPopular;

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
      this.image,
      this.pricePerUnit,
      this.isFavourite,
      this.isPopular});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        id: json['id'],
        name: json['name'].toString(),
        type: json['type'].toString(),
        route: json['route'].toString(),
        strength: json['strength'].toString(),
        usage: json['usage'].toString(),
        dosage: json['dosage'].toString(),
        categoryId: json['category_id'],
        units: json['units'],
        image: json['image'].toString(),
        pricePerUnit: json['price_per_unit'],
        isFavourite: json['isFavourite'],
        isPopular: json['isPopular']);
  }
}

//get Medications

getMedication() async {
  var endPoint = '/medications';
  var response = await Network().getRequest(endPoint);
  List<Medication> medications = [];

  var body = json.decode(response.body);
  for (var item in body['data']) {
    //pass question to constructor
    Medication medication = Medication.fromJson(item);
    medications.add(medication);
  }

  return medications;
}

//get Featured Medications

getFeaturedMedication() async {
  var endPoint = '/featured-medications';
  var response = await Network().getRequest(endPoint);
  List<Medication> medications = [];

  var body = json.decode(response.body);
  for (var item in body['data']) {
    //pass question to constructor
    Medication medication = Medication.fromJson(item);
    medications.add(medication);
  }

  return medications;
}

searchMedication(query) async {
  var endPoint = '/search/' + query;
  var response = await Network().getRequest(endPoint);
  List<Medication> medications = [];
  var body = json.decode(response.body);
  for (var item in body['data']) {
    //pass question to constructor
    print(item);
    Medication medication = Medication.fromJson(item);
    medications.add(medication);
  }

  return medications;
}
