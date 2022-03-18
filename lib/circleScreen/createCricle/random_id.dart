// ignore_for_file: use_key_in_widget_constructors, annotate_overrides, avoid_renaming_method_parameters, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/circleScreen/components/HeaderCircle.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

const kPrimaryColor = Color(0xffF8F1DB);
const kTextColor = Color(0xff000000);
const kBackgroundColor = Color(0xffF9EE6D);
const kCircle = Color(0xffFFC34A);
const double kDefaultPadding = 34.0;

class Random_id extends StatefulWidget {
  final String circle_code;
  Random_id({required this.circle_code});
  @override
  State<Random_id> createState() => _Random_idState();
}

class _Random_idState extends State<Random_id> {
  List<CircleModel> circleModels = [];

  @override
  void initState() {
    super.initState();
    pullCircle();
  }

  Future<Null> pullCircle() async {
    String circle_code = widget.circle_code.toString();
    String pullCircle =
        '${MyConstant.domain}/famfam/getCircleWhereCode.php?isAdd=true&circle_code=$circle_code';
    await Dio().get(pullCircle).then((value) async {
      for (var item in json.decode(value.data)) {
        CircleModel model = CircleModel.fromMap(item);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('circle_id', model.circle_id!);
        setState(() {
          circleModels.add(model);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                            //   ID_Field(
                            //     //hintText: 'Some variable generated',
                            //     onChanged: (String value) {},
                            // ),
                            Center(
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 40),
                                    height: size.height * 0.12 - 37,
                                    width: size.width * 0.75,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                hexToColor('#FFFFFF')),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                          text: widget.circle_code,
                                        ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Copied to clipboard')));
                                      },
                                      child: Text(
                                        widget.circle_code,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: hexToColor('#000000')),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 270),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 36),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: size.height * 0.1 - 37,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                hexToColor(
                                                                    '#AD8002')),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? circle_id =
                                                        preferences.getString(
                                                            'circle_id');
                                                    String deleteCircle =
                                                        "${MyConstant.domain}/famfam/deleteCircleWhereID.php?isAdd=true&circle_id=$circle_id";
                                                    await Dio()
                                                        .get(deleteCircle)
                                                        .then((value) async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      preferences
                                                          .clear()
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    });
                                                  },
                                                  child: Text(
                                                    "Back",
                                                    style: TextStyle(
                                                        fontSize: 21,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.blue,
                                              width: 100,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: size.height * 0.1 - 37,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                hexToColor(
                                                                    '#FFC34A')),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomePage(
                                                                          user),
                                                            ),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  },
                                                  child: Text(
                                                    "Next",
                                                    style:
                                                        TextStyle(fontSize: 21),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
