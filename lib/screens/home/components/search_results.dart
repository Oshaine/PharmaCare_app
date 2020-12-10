import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/details/details_screen.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/size_config.dart';

class SearchResults extends StatefulWidget {
  final dynamic query;

  SearchResults(this.query);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text("Medications"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            HomeHeader(headerText: "PharmaCare"), //Header
            SizedBox(height: getProportationateScreenWidth(20)),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 15.0, left: 15.0),
                      height: getProportationateScreenHeight(500),
                      child: FutureBuilder(
                        future: widget.query,
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
                                          snapshot.data[index].pricePerUnit
                                              .toString(),
                                      '${Network().serverPath + 'storage/' + snapshot.data[index].image.toString()}',
                                      context,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: getProportationateScreenWidth(10)),
                              ],
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Widget _buildCard(String name, String price, String imgPath, context) {
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
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
                  color: kPrimaryColor, fontFamily: 'Varela', fontSize: 14.0)),
          Text(name,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Varela', fontSize: 14.0)),
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
                        fontSize: 12.0))
              ],
            ),
          )
        ],
      ),
    ),
  );
}
