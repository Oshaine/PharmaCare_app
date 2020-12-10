import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/size_config.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({
    Key key,
    @required this.text,
    @required this.iconData,
    @required this.press,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: press,
        child: Container(
          padding: EdgeInsets.all(getProportationateScreenWidth(8)),
          child: ListTile(
            leading: Icon(
              iconData,
              color: Colors.indigo,
            ),
            title: Text(text),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
