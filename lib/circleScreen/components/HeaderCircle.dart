// ignore: file_names
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class HeaderCircle extends StatelessWidget {
  const HeaderCircle({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height * 0.26,
          width: size.width * 1,
          color: Color(0xFFF9EE6D),
          child: Stack(children: <Widget>[
            Positioned(
                bottom: -125,
                left: -140,
                child: Image.asset("assets/images/circleOnbg.png")),
            Positioned(
                height: 200,
                right: 82,
                top: -35,
                child: Image.asset("assets/images/cNew.png")),
            Positioned(
                height: 200,
                right: 10,
                bottom: -21,
                child: Image.asset("assets/images/14cc.png")),
            Positioned(
                height: 200,
                right: -44,
                bottom: -75,
                child: Image.asset("assets/images/ccNew.png"))
          ]),
        ),
        Container(
          padding: EdgeInsets.only(left: 34, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Circle',
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 10),
              Text(
                  '(n.) Group of people that wanted to share \n a moment together in fam-fam application. ',
                  style: TextStyle(
                      fontSize: 16.5,
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.normal,
                      //letterSpacing: 1.0
                      height: 1.8)),
            ],
          ),
        ),
      ],
    );
  }
}
