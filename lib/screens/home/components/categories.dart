import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Category.dart';
import 'package:pharmacare_app/size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Vitamins"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Antibiotics"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Injections"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Pain Killer"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
      {"icon": "assets/icons/Discover.svg", "text": "Capsules"},
    ];

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportationateScreenWidth(5)),
        child: FutureBuilder(
          future: getCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportationateScreenWidth(15)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        snapshot.data.length,
                        (index) => CategoryCard(
                          text: snapshot.data[index].name,
                          icon: categories[index]['icon'],
                          press: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // return ListView.builder(
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (context, index) {

              //   },
              // );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportationateScreenWidth(55),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportationateScreenWidth(2)),
                padding: EdgeInsets.all(getProportationateScreenWidth(12)),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  icon,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: getProportationateScreenWidth(10)),
            )
          ],
        ),
      ),
    );
  }
}
