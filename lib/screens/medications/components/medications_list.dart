import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Category.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/details/details_screen.dart';
import 'package:pharmacare_app/size_config.dart';

class MedicationList extends StatefulWidget {
  const MedicationList({
    Key key,
    @required this.category,
    // @required this.press,
  }) : super(key: key);

  final Category category;

  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  getMedicationList() async {
    var endPoint = '/medication-categories';
    var response = await Network().postRequest(endPoint, 2);
    List<Category> categories = [];

    Map<String, dynamic> body = json.decode(response.body);

    for (var item in body['data']) {
      //pass category to constructor
      Category category = Category.fromJson(item);

      categories.add(category);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: getProportationateScreenHeight(320),
            child: FutureBuilder(
              future: getMedication(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1,
                    children: [
                      ...List.generate(
                        snapshot.data.length,
                        (index) => InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: MedicationDetailsArgs(
                                medication: snapshot.data[index]),
                          ),
                          child: _buildCard(
                              snapshot.data[index].name,
                              '\$' +
                                  snapshot.data[index].pricePerUnit.toString(),
                              '${Network().serverPath + 'storage/' + snapshot.data[index].image.toString()}',
                              context),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: imgPath,
                  child: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imgPath), fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Text(price,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'Varela',
                      fontSize: 14.0)),
              Text(name,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Varela',
                      fontSize: 14.0)),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.shopping_basket,
                        color: kPrimaryLightColor, size: 12.0),
                    Text('Add to cart',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: kPrimaryColor,
                            fontSize: 12.0)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
