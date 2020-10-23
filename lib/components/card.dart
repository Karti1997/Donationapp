import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final BoxDecoration decoration;
  final String image;
  final String number;
  final String name;
  final Widget company;

  const CreditCard({
    this.decoration,
    this.image,
    this.number,
    this.name,
    this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 300,
      height: 300,
      decoration: decoration,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: company,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Image.asset(
                image,
                height: 50,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
