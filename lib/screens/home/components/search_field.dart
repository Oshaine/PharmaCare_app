import 'package:flutter/material.dart';
import 'package:pharmacare_app/models/Medication.dart';
import 'package:pharmacare_app/screens/home/components/search_results.dart';
import 'package:pharmacare_app/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      // height: 50,
      decoration: BoxDecoration(
        color: Colors.white..withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          value = value.toLowerCase();
        },
        onSubmitted: (query) {
          var data = searchMedication(query);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchResults(data),
              ));
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search Medication",
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportationateScreenHeight(20),
              vertical: getProportationateScreenWidth(9)),
        ),
      ),
    );
  }
}
