import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportationateScreenWidth(20),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getProportationateScreenWidth(20),
          vertical: getProportationateScreenWidth(15)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          text: "Covid 19 Discount Prices\n",
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
                text: "Hot Sale 20%",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
