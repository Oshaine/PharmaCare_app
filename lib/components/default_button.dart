import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportationateScreenWidth(150),
      height: getProportationateScreenHeight(50),
      child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
              onPressed: press,
        child: Text(text,
            style: TextStyle(
              fontSize: getProportationateScreenWidth(12),
              color: Colors.white,
            )),
      ),
    );
  }
}
