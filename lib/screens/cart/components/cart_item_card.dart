import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/rounded_icon_btn.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/Cart.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/size_config.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  var total = 0.0;

  @override
  void initState() {
    setState(() {
      if (widget.cart.total == null) {
        widget.cart.total = widget.cart.medication.pricePerUnit;
      } else {
        widget.cart.total =
            widget.cart.medication.pricePerUnit * widget.cart.numOfItems;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportationateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                '${Network().serverPath + 'storage/' + widget.cart.medication.image.toString()}',
              ),
            ),
          ),
        ),
        SizedBox(width: getProportationateScreenWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cart.medication.name,
              style: TextStyle(fontSize: 16, color: Colors.black),
              maxLines: 2,
            ),
            // Text(widget.cart.total.toStringAsFixed(2)),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${widget.cart.medication.pricePerUnit}",
                style: TextStyle(color: kPrimaryColor),
                children: [
                  TextSpan(
                    text: " x${widget.cart.numOfItems}",
                    style: TextStyle(color: kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 35),
            Row(
              children: [
                // Spacer(),
                RoundedIconBtn(
                  icon: Icons.remove,
                  press: () {
                    widget.cart.numOfItems--;
                    setState(() {
                      widget.cart.total = total;
                      if (widget.cart.numOfItems < 1) {
                        widget.cart.numOfItems = 1;
                      } else {
                        total = (widget.cart.medication.pricePerUnit *
                            widget.cart.numOfItems);
                        widget.cart.total = total;
                      }
                    });
                  },
                ),
                SizedBox(
                  width: getProportationateScreenWidth(15),
                ),
                RoundedIconBtn(
                  icon: Icons.add,
                  press: () {
                    setState(() {
                      widget.cart.numOfItems++;
                      total = (widget.cart.medication.pricePerUnit *
                          widget.cart.numOfItems);
                      widget.cart.total = total;
                    });
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
