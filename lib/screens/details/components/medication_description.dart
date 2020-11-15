import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/Category.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/size_config.dart';

class MedicationDescription extends StatefulWidget {
  const MedicationDescription({
    Key key,
    @required this.medication,
    @required this.pressOnSeeMore,
  }) : super(key: key);

  final Medication medication;
  final GestureTapCallback pressOnSeeMore;

  @override
  _MedicationDescriptionState createState() => _MedicationDescriptionState();
}

String category;

class _MedicationDescriptionState extends State<MedicationDescription> {
  @override
  void initState() {
    findCategory();
    super.initState();
  }

  void findCategory() {
    getCategory().then((value) {
      for (var item in value) {
        if (widget.medication.categoryId == item.id) {
          setState(() {
            category = item.name;
            print(category);
          });
        }
      }
    });
    // return category;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportationateScreenWidth(20)),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.medication.name,
              style: TextStyle(
                  fontSize: getProportationateScreenWidth(20),
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     padding: EdgeInsets.all(getProportationateScreenWidth(15)),
        //     width: getProportationateScreenWidth(64),
        //     decoration: BoxDecoration(
        //         color: medication.isFavourite == 1
        //             ? Color(0xFFFFE6E6)
        //             : Color(0xFFF5F6F9),
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(20),
        //             bottomLeft: Radius.circular(20))),
        //     child: SvgPicture.asset(
        //       "assets/icons/Heart Icon_2.svg",
        //       color: medication.isFavourite == 1
        //           ? Color(0xFFFF4848)
        //           : Color(0xFFDBDEE4),
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(
              left: getProportationateScreenWidth(20),
              right: getProportationateScreenWidth(64),
              bottom: getProportationateScreenWidth(20)),
          child: Text(
            "Medication Summary",
            style: TextStyle(fontSize: getProportationateScreenWidth(18)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: getProportationateScreenWidth(20),
            right: getProportationateScreenWidth(64),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Type - " + widget.medication.type),
              Text("Category - " + category),
              Text("Strength - " + widget.medication.strength),
              Text("Route - " + widget.medication.route),
              Text("Usage - " + widget.medication.usage),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportationateScreenWidth(20),
                vertical: 10,
              ),
              // child: GestureDetector(
              //   onTap: pressOnSeeMore,
              //   child: Row(
              //     children: [
              //       Text(
              //         "See More Details",
              //         style: TextStyle(
              //             color: kPrimaryColor, fontWeight: FontWeight.w600),
              //       ),
              //       SizedBox(width: 5),
              //       Icon(
              //         Icons.arrow_forward_ios,
              //         size: 12,
              //         color: kPrimaryColor,
              //       )
              //     ],
              //   ),
              // ),
            )
          ],
        )
      ],
    );
  }
}
