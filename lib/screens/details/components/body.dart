import 'package:flutter/material.dart';
import 'package:pharmacare_app/api/api.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/details/components/medication_description.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/size_config.dart';

class Body extends StatelessWidget {
  final Medication medication;

  const Body({Key key, @required this.medication}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(headerText: "PharmaCare"),
          MedicationImage(medication: medication),
          //Medication Details Main Container
          TopRoundedContainer(
            color: Colors.white,
            //Medication description
            child: Column(
              children: [
                MedicationDescription(
                  medication: medication,
                  pressOnSeeMore: () {},
                ),
                // TopRoundedContainer(
                //   color: kPrimaryLightColor,
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: getProportationateScreenWidth(20)),
                //     child: Row(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(8),
                //           height: getProportationateScreenWidth(40),
                //           width: getProportationateScreenWidth(40),
                //           decoration: BoxDecoration(
                //               color: products[0].color, shape: BoxShape.circle),
                //         ),
                //         Spacer(),
                //         RoundedIconBtn(
                //           icon: Icons.remove,
                //           press: () {},
                //         ),
                //         SizedBox(
                //           width: getProportationateScreenWidth(15),
                //         ),
                //         RoundedIconBtn(
                //           icon: Icons.add,
                //           press: () {},
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: getProportationateScreenWidth(15),
          ),
          DefaultButton(
            text: "Add to Cart",
            press: () {},
          )
        ],
      ),
    );
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
