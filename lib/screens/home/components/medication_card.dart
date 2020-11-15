import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/size_config.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard({
    Key key,
    this.width = 140,
    this.aspectRetion = 1.02,
    @required this.medication,
    @required this.press,
  }) : super(key: key);

  final double width, aspectRetion;
  final Medication medication;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportationateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportationateScreenWidth(width),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRetion,
                child: (Container(
                  padding: EdgeInsets.all(getProportationateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    '${Network().serverPath + 'storage/' + medication.image.toString()}',
                  ),
                )),
              ),
              const SizedBox(height: 5),
              Text(
                medication.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${medication.pricePerUnit}",
                    style: TextStyle(
                        fontSize: getProportationateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportationateScreenWidth(8)),
                      width: getProportationateScreenWidth(28),
                      height: getProportationateScreenWidth(28),
                      decoration: BoxDecoration(
                          color: medication.isFavourite == 1
                              ? kPrimaryColor.withOpacity(0.15)
                              : kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: medication.isFavourite == 1
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE8),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
