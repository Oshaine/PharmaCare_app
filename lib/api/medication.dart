// import 'package:APITester/api/api_util.dart';
// import 'package:APITester/models/category.dart';
// import 'package:APITester/models/question.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class CategoryAPI {
//   Future<List<Category>> fetchAllCategories() async {
//     //api url from APIUtil class
//     String allCategories = APIUtil.MAIN_API_URL + APIUtil.ALL_CATEGORIES;
//     Map<String, String> headers = {'Accept': 'application/json'};

//     //pass url and header to http get request
//     var response = await http.get(allCategories, headers: headers);

//     List<Category> categories = [];
//     if (response.statusCode == 200) {
//       //convert response data body to list
//       Map<String, dynamic> body = jsonDecode(response.body);
//       for (var item in body['data']) {
//         //pass question to constructor
//         Category category = Category.fromJson(item);
//         categories.add(category);
//       }
//     }
//     return categories;
//   }
// }
