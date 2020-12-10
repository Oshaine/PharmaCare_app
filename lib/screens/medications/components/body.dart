import 'package:flutter/material.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Category.dart';
import 'package:pharmacare_app/screens/home/components/home_header.dart';
import 'package:pharmacare_app/screens/medications/components/medications_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int length;
  var categories = [];
  @override
  void initState() {
    super.initState();
    getCategory().then((value) {
      setState(() {
        length = value.length;
        categories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: this.length, vsync: this);

    return ListView(
      children: [
        HomeHeader(headerText: "PharmaCare"), //Header

        SizedBox(height: 15.0),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: kPrimaryColor,
          isScrollable: true,
          labelPadding: EdgeInsets.only(right: 45.0),
          unselectedLabelColor: kPrimaryLightColor,
          tabs: List<Widget>.generate(
            categories.length,
            (int index) {
              return new Tab(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    categories[index].name,
                    style: TextStyle(fontSize: 21.0),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: double.infinity,
          child: TabBarView(
            controller: _tabController,
            children: [
              ...List.generate(
                  length,
                  (index) => MedicationList(
                        category: categories[index],
                      )),
            ],
          ),
        )
      ],
    );
  }
}
