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
            return category;
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
        Padding(
          padding: EdgeInsets.only(
              left: getProportationateScreenWidth(20),
              right: getProportationateScreenWidth(64),
              bottom: getProportationateScreenWidth(20)),
          child: Text(
            "Medication Summary",
            style: TextStyle(
              fontSize: getProportationateScreenWidth(18),
            ),
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
            )
          ],
        )
      ],
    );
  }
}
