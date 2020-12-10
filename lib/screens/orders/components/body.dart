import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/User.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Orders();
  }
}

class Orders extends StatefulWidget {
  const Orders({
    Key key,
  }) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var user;
  @override
  void initState() {
    User().getUserInfo().then((value) {
      setState(() {
        user = value;
        getUserOrders();
      });
    });
    super.initState();
  }

//get user orders
  getUserOrders() async {
    var endPoint = '/user-orders';
    var response = await Network().postRequest(user, endPoint);
    print(json.decode(response.body));
    List<dynamic> body = json.decode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: FutureBuilder(
          future: getUserOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ...List.generate(
                    snapshot.data.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportationateScreenWidth(5),
                          vertical: getProportationateScreenWidth(5)),
                      child: Card(
                        elevation: 2,
                        // clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              dense: true,
                              leading: Text(snapshot.data[index]['order_number']
                                  .toString()),
                              trailing: Text(snapshot.data[index]['status']),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Items',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Text(
                                    snapshot.data[index]['items']
                                        .map((item) => item['name'])
                                        .toString()
                                        .replaceAll('(', '')
                                        .replaceAll(')', ''),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    '\$ ' +
                                        snapshot.data[index]['grand_total']
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Image.network(
                            //     'https://icecream.prowebtec.com/opencart/images/powertrack/track.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                child: Center(
                  heightFactor: 25.0,
                  child: Text(
                    'Loading Orders...',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
