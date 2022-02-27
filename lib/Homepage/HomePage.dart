import 'dart:math';
import 'package:famfam/Homepage/menuHome.dart';
import 'package:famfam/Homepage/tabbar.dart';
import 'package:famfam/check-in/Checkin.dart';
import 'package:flutter/material.dart';
// import 'package:famfam/Homepage/eachMenu.dart';

import 'package:famfam/circleScreen/createCricle/body_random.dart';
import 'package:flutter/cupertino.dart';

import 'package:famfam/Homepage/date.dart';

final Color backgroundColor = Color(0xFFE7C581);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double value = 0;
  String family = "Family Name";
  String name = "Janejira";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: backgroundColor),
        ),
        SafeArea(child: menuHome()),

        //Main Screen
        TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: Duration(milliseconds: 500),
            builder: (___, double val, __) {
              return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, -280 * val)
                    ..rotateY(-(pi / 6) * val),
                  child: Scaffold(
                      //Main Screean
                      body: SafeArea(
                          child: Container(
                              child: SingleChildScrollView(
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.orange),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                child: Text(
                                  family,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Text(
                                        "Hey, ",
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        name + "!",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 60),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.menu_open_rounded,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      value == 0 ? value = 1 : value = 0;
                                    });
                                  }))
                        ],
                      ),
                      Date(),
                      tabbar()
                    ]),
                  ))))));
            }),

        //open drawer
        // GestureDetector(
        //   onHorizontalDragUpdate: (e) {
        //     if (e.delta.dx < 0) {
        //       setState(() {
        //         value = 1;
        //       });
        //     } else {
        //       setState(() {
        //         value = 0;
        //       });
        //     }
        //   },
        // )
      ],
    ));
  }
}
