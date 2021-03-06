import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:famfam/Homepage/menuHome.dart';
import 'package:famfam/Homepage/tabbar.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/history_for_user_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/auth.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/widgets/circle_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:famfam/services/auth.dart';
import 'package:famfam/models/calendar_model.dart';
import 'package:flutter/material.dart';
// import 'package:famfam/Homepage/eachMenu.dart';

import 'package:famfam/Homepage/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = Color(0xFFE7C581);

class HomePage extends StatefulWidget {
  var user = FirebaseAuth.instance.currentUser;
  HomePage(this.user, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool load = true;
  List<CalendarModel> calendarModels = [];
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  List<HistoryForUserModel> historyForUserModel = [];
  String family = 'loading..';
  String name = 'loading..';
  String profileImage =
      'https://firebasestorage.googleapis.com/v0/b/famfam-c881b.appspot.com/o/userProfile%2FcircleOnbg.png?alt=media&token=80bc8cea-30d6-41d7-8896-c86c021e059e';

  @override
  void initState() {
    value = 0;
    super.initState();
    pullUserSQLID().then((value) => pullCircle().then((value) {
          name = userModels[0].fname;
          family = circleModels[0].circle_name;

          profileImage = userModels[0].profileImage;
        }));
  }

  Future<Null> pullUserSQLID() async {
    final String getUID = FirebaseAuth.instance.currentUser!.uid.toString();
    String uid = getUID;
    String pullUser =
        '${MyConstant.domain}/famfam/getUserWhereUID.php?isAdd=true&uid=$uid';
    await Dio().get(pullUser).then((value) async {
      if (value.toString() == null ||
          value.toString() == 'null' ||
          value.toString() == '') {
        FirebaseAuth.instance.signOut();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);
          setState(() {
            userModels.add(model);
          });
        }
      }
    });
  }

  Future<Null> pullCircle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');
    String? member_id = userModels[0].id;

    String pullCircle =
        '${MyConstant.domain}/famfam/getCircleWhereCircleIDuserID.php?isAdd=true&circle_id=$circle_id&member_id=$member_id';
    await Dio().get(pullCircle).then((value) async {
      for (var item in json.decode(value.data)) {
        CircleModel model = CircleModel.fromMap(item);
        setState(() {
          circleModels.add(model);
          load = false;
        });
      }
    });
  }

  final User user = FirebaseAuth.instance.currentUser!;
  double value = 0;
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? CircleLoader()
          : Stack(
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
                          //Main Screen
                          body: SafeArea(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 100),
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                20, 20, 0, 0),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  NetworkImage(profileImage),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    15, 20, 0, 0),
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
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              15, 0, 0, 0),
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 30, 30, 0),
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.menu_open_rounded,
                                                size: 40,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  value == 0
                                                      ? value = 1
                                                      : value = 0;
                                                });
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Date(),
                                tabbar()
                              ]),
                            ),
                          ),
                        ),
                      ));
                    }),
              ],
            ),
    );
  }
}
