import 'package:flutter/material.dart';
import 'package:pharmacare_app/size_config.dart';

class SectionTtile extends StatelessWidget {
  const SectionTtile({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportationateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: getProportationateScreenWidth(18),
                color: Colors.black),
          ),
          GestureDetector(onTap: press, child: Text("See More")),
        ],
      ),
    );
  }
}
