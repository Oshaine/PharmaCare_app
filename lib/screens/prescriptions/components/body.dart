import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:intl/intl.dart';
import 'package:pharmacare_app/models/User.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/prescriptions/components/prescription_checkout.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var user;
  @override
  void initState() {
    User().getUserInfo().then((value) {
      setState(() {
        user = value;
        // User().getUserPrescriptions(user);
      });
    });
    super.initState();
  }

  saveUserPrescription(prescription) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //save prescription
    localStorage.setString("prescription", json.encode(prescription));

    Navigator.pushNamed(context, PrescriptionCheckoutScreen.routeName);
  }

  showAlertDialog(BuildContext context, prescription) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Text(
          'Order Number ' + prescription['order_number'].toString(),
          style: TextStyle(fontSize: 14.0),
        ),
        content: Container(
          height: getProportationateScreenHeight(200),
          child: Column(
            children: [
              Text(
                "Items",
                style: TextStyle(color: kPrimaryColor, fontSize: 24.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        prescription['items']
                                .map((value) => value['name'])
                                .toString()
                                .replaceAll('(', "")
                                .replaceAll(")", "") +
                            " x" +
                            prescription['items']
                                .map((value) => value['pivot']['quantity'])
                                .toString(),
                      ),
                    ],
                  ),
                  Text(
                    '\$' +
                        prescription['items']
                            .map((value) => value['price_per_unit'])
                            .toString()
                            .replaceAll('(', "")
                            .replaceAll(")", ""),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total \$" + prescription['grand_total'].toString()),
                  Text(
                    prescription['is_paid'] == 1 ? "Paid" : "Not Paid",
                    style: TextStyle(
                        color: prescription['is_paid'] == 1
                            ? Colors.green[200]
                            : Colors.red[200],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Status"),
                  Text(prescription['status']),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Date "),
                  Text(DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(prescription['created_at']))
                      .toString())
                ],
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 10.0, bottom: 20.0),
        actions: [
          prescription['is_paid'] != 1
              ? Container(
                  child: Row(
                    children: [
                      DefaultButton(
                        text: "Make Payment",
                        press: () {
                          saveUserPrescription(prescription);
                        },
                      ),
                      cancelButton,
                    ],
                  ),
                )
              : okButton,
        ]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: User().getUserPrescriptions(user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showAlertDialog(context, snapshot.data[index]);
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            snapshot.data[index]['is_paid'] == 1
                                ? "Paid"
                                : "Not Paid",
                            style: TextStyle(
                                color: snapshot.data[index]['is_paid'] == 1
                                    ? Colors.green[200]
                                    : Colors.red[200],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.network(
                            '${Network().serverPath + 'storage/' + snapshot.data[index]['image'].toString()}',
                            height: 100,
                          ),
                          Text(
                            snapshot.data[index]['grand_total'] != null
                                ? 'Total \$' +
                                    snapshot.data[index]['grand_total']
                                        .toString()
                                : 'Total: Pending',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text("Status: " + snapshot.data[index]['status'])
                        ],
                      ),
                    ),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              );
            } else {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
