// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../components/text_field_create.dart';
import '../components/HeaderCircle.dart';

//Colors that we use in app
const kPrimaryColor = Color(0xffF8F1DB);
const kTextColor = Color(0xff000000);
const kBackgroundColor = Color(0xffF9EE6D);
const kCircle = Color(0xffFFC34A);
const double kDefaultPadding = 34.0;

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderCircle(size: size),
          Container(
            color: Color(0xFFF9EE6D),
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width * 1,
                  height: size.height * 0.74,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65),
                      topRight: Radius.circular(65),
                    ),
                  ),
                  child: Stack(children: <Widget>[
                    Container(
                      height: size.height * 0.74,
                      margin: EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(66),
                            topRight: Radius.circular(66),
                          )),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 34, top: 55),
                            child: Text(
                              'Let\'s create Circle ID!',
                              style: TextStyle(
                                fontSize: 34,
                                //fontFamily: 'Merriweather',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 34, right: 36),
                            child: Text(
                              '\nJust name your circle and enter it in the box below. Fam-Fam will build Circle ID     for you.',
                              style: TextStyle(
                                fontSize: 19,
                                //fontFamily: 'Merriweather',
                                fontWeight: FontWeight.normal,
                                //letterSpacing: 1.0
                                height: 1.3,
                              ),
                            ),
                          ),
                          // RoundedInputField(
                          //   hintText: 'Ex. Sabaidee Family',
                          //   onChanged: (String value) {},
                          // ),
                          EnterCircleID(child: Container())
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
