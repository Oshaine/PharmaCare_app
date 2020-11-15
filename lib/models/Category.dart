import 'dart:convert';

import 'package:pharmacare_app/models/api.dart';

class Category {
  final int id;
  final String name;
  final String description;

  Category({this.id, this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'], name: json['name'], description: json['description']);
  }
}

Future<List<Category>> getCategory() async {
  var endPoint = '/categories';
  var response = await Network().getRequest(endPoint);
  List<Category> categories = [];

  Map<String, dynamic> body = json.decode(response.body);

  for (var item in body['data']) {
    //pass category to constructor
    Category category = Category.fromJson(item);

    categories.add(category);
  }
  return categories;
}
