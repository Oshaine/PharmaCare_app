import 'package:flutter/material.dart';
import 'package:pharmacare_app/size_config.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    this.headerText,
    this.subText,
  }) : super(key: key);
  final String headerText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.2,
          decoration: BoxDecoration(
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage('assets/images/Image Banner 2.png'),
              // ),
              color: Colors.lightBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(120),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.15))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    headerText,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                            offset: Offset(0, 2.5),
                            blurRadius: 10,
                            color: Colors.black)
                      ],
                      color: Colors.white,
                      fontSize: getProportationateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
              // SvgPicture.asset(
              //   'assets/svg/medicine.svg',
              //   height: 100,
              // ),
            ],
          ),
        )
      ],
    );
  }
}
