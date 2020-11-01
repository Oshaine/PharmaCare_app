import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacare_app/size_config.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({Key key, @required this.svgIcon}) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportationateScreenWidth(20),
        getProportationateScreenWidth(20),
        getProportationateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportationateScreenHeight(16),
      ),
    );
  }
}
