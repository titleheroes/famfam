// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, use_key_in_widget_constructors

import 'package:famfam/circleScreen/components/id_field.dart';
import 'package:flutter/material.dart';

import '../components/HeaderCircle.dart';

//Colors that we use in app
const kPrimaryColor = Color(0xffF8F1DB);
const kTextColor = Color(0xff000000);
const kBackgroundColor = Color(0xffF9EE6D);
const kCircle = Color(0xffFFC34A);
const double kDefaultPadding = 34.0;



class IDBody extends StatelessWidget {
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
                height: size.height * 0.75,
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(65),
                    topRight: Radius.circular(65),
                  ),
                ),
                child: Stack(children: <Widget>[
                  Container(
                    height: size.height * 0.75,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(65),
                          topRight: Radius.circular(65),
                        )),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 34, top: 55),
                          child: Text(
                            'It\'s your circle ID!',
                            style: TextStyle(
                              fontSize: 29,
                              //fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(left: 34),
                          child: Text(
                            '\nI\'m glad you created it successfully. Please remember the Circle ID or you just tap on Circle ID and it will copy for you.',
                            style: TextStyle(
                              fontSize: 19,
                              //fontFamily: 'Merriweather',
                              fontWeight: FontWeight.w400,                         
                              height: 1.3,
                            ),
                          ),
                        ),
                        ID_Field(
                          //hintText: 'Some variable generated',
                          onChanged: (String value) {},
                      ),
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
