import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/components/rounded_icon_btn.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Cart.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/cart/cart_screen.dart';
import 'package:pharmacare_app/screens/details/components/medication_description.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatefulWidget {
  final Medication medication;

  const Body({Key key, @required this.medication}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var count = 1;
  var total = 0.00;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(headerText: "PharmaCare"),
          MedicationImage(medication: widget.medication),
          //Medication Details Main Container
          TopRoundedContainer(
            color: Colors.white,
            //Medication description
            child: Column(
              children: [
                MedicationDescription(
                  medication: widget.medication,
                  pressOnSeeMore: () {},
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportationateScreenWidth(20)),
                      child: Text("Quantity $count"),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportationateScreenWidth(30)),
                      child: RoundedIconBtn(
                        icon: Icons.remove,
                        press: () {
                          count--;
                          setState(() {
                            if (count < 1) {
                              count = 1;
                              for (int i = 0; i < cart.length; i++) {
                                cart[i].numOfItems = count;
                                total = cart[i].medication.pricePerUnit * count;
                              }
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportationateScreenWidth(15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportationateScreenHeight(30)),
                      child: RoundedIconBtn(
                        icon: Icons.add,
                        press: () {
                          setState(() {
                            count++;
                            for (int i = 0; i < cart.length; i++) {
                              cart[i].numOfItems = count;
                              cart[i].total =
                                  (cart[i].medication.pricePerUnit * count);
                            }
                          });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: getProportationateScreenWidth(15),
          ),
          DefaultButton(
            text: "Add to Cart",
            press: () {
              if (addToCart(widget.medication, count)) {
                Navigator.pushNamed(context, CartScreen.routeName);
              }
            },
          ),
          SizedBox(
            height: getProportationateScreenWidth(20),
          )
        ],
      ),
    );
  }

  bool addToCart(medication, itemCount) {
    cart.add(Cart(medication: medication, numOfItems: itemCount));
    return true;
  }
}

class MedicationImage extends StatefulWidget {
  const MedicationImage({
    Key key,
    @required this.medication,
  }) : super(key: key);

  final Medication medication;

  @override
  _MedicationImageState createState() => _MedicationImageState();
}

class _MedicationImageState extends State<MedicationImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportationateScreenWidth(200),
          child: AspectRatio(
            aspectRatio: 1.1,
            child: Image.network(
              '${Network().serverPath + 'storage/' + widget.medication.image.toString()}',
            ),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     // buildSmallPreview(),
        //   ],
        // )
      ],
    );
  }

  Container buildSmallPreview() {
    return Container(
      padding: EdgeInsets.all(getProportationateScreenHeight(8)),
      height: getProportationateScreenWidth(48),
      width: getProportationateScreenWidth(48),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor)),
      child: Image.network(
        '${Network().serverPath + 'storage/' + widget.medication.image.toString()}',
      ),
    );
  }
}

//Medication Details Container

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportationateScreenWidth(20)),
      padding: EdgeInsets.only(top: getProportationateScreenWidth(20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}
