import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/Homepage/history.dart';
import 'package:famfam/check-in/Checkin.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/history_for_user_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/screens/voterandom_screen.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = Color(0xFFE7C581);

class menuHome extends StatefulWidget {
  menuHome({Key? key}) : super(key: key);
  @override
  State<menuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<menuHome> {
  final user = FirebaseAuth.instance.currentUser!;
  double value = 0;
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  List<HistoryForUserModel> historyForUserModel = [];
  bool history_status = false;

  @override
  void initState() {
    value = 0;
    super.initState();
    pullUserSQLID().then(
      (value) => pullCircle().then((value) {
        pullHistory().then((value) {
          if (historyForUserModel[0].history_status == '1') {
            setState(() {
              history_status = true;
            });
          }
        });
      }),
    );
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
        });
      }
    });
  }

  Future<Null> pullHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');
    String? user_id = userModels[0].id;

    String pullHistoryForUser =
        '${MyConstant.domain}/famfam/getHistoryForUser.php?isAdd=true&user_id=$user_id&circle_id=$circle_id';
    await Dio().get(pullHistoryForUser).then((value) async {
      for (var item in json.decode(value.data)) {
        HistoryForUserModel model = HistoryForUserModel.fromMap(item);
        setState(() {
          historyForUserModel.add(model);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 160, top: 75),
      height: MediaQuery.of(context).size.height,
      child: Container(
        // alignment: Alignment.centerLeft,
        child: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 175,
                ),
                Stack(
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.history_sharp,
                        ),
                        color: Colors.white,
                        iconSize: 36,
                        onPressed: () async {
                          String? circle_id = circleModels[0].circle_id;
                          String? user_id = userModels[0].id;
                          int history_status = 0;
                          String updateHistoryForUserStatus =
                              '${MyConstant.domain}/famfam/editHistoryForUserrStatus.php?isAdd=true&circle_id=$circle_id&user_id=$user_id&history_status=$history_status';
                          await Dio()
                              .get(updateHistoryForUserStatus)
                              .then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => History(),
                              ),
                            ).then(
                              (value) => setState(() {}),
                            );
                          });
                        },
                      ),
                    ),
                    Builder(builder: (context) {
                      if (history_status == false) {
                        return Positioned(
                          child: Container(
                            child: Icon(
                              Icons.circle,
                              color: Colors.transparent,
                            ),
                          ),
                        );
                      } else {
                        return Positioned(
                          child: Container(
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(user),
                  ),
                );
              },
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/pinpost');
              },
              leading: Icon(
                Icons.note_rounded,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Pin Post",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/checkin');
            //   },
            //   leading: Icon(
            //     Icons.gps_fixed,
            //     color: Colors.white,
            //     size: 35,
            //   ),
            //   title: Text(
            //     "Check-In",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                // Navigator.pushNamed(context, ('/voterandom'));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VoteRandomScreen(),
                  ),
                );
              },
              leading: Icon(
                Icons.casino,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "V and R",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // ListTile(
            //   onTap: () {},
            //   leading: Icon(
            //     Icons.wallet_giftcard_rounded,
            //     color: Colors.white,
            //     size: 35,
            //   ),
            //   title: Text(
            //     "Rewardory",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => settingPage()));
              },
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Setting",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
