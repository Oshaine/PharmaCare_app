import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/Cart.dart';
import 'package:pharmacare_app/screens/cart/cart_screen.dart';
import 'package:pharmacare_app/screens/home/components/icon_btn_counter.dart';
import 'package:pharmacare_app/screens/home/components/search_field.dart';
import 'package:pharmacare_app/size_config.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
    this.headerText,
  }) : super(key: key);

  final String headerText;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchField(),
                      SizedBox(
                        width: getProportationateScreenWidth(20),
                      ),
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Bell.svg",
                        numOfItems: 3,
                        press: () {},
                      ),
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Cart Icon.svg",
                        numOfItems: cart.length,
                        press: () =>
                            Navigator.pushNamed(context, CartScreen.routeName),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
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
