import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/auth.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/circle/circle.dart';
import 'package:famfam/settingPage/create&join/create&join.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/privacy/changepass.dart';
import 'package:famfam/settingPage/profile/Profile.dart';
import 'package:famfam/settingPage/about/about.dart';
import 'package:famfam/settingPage/help/help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Family {
  String idFamily;
  String name;
  String profile;
  Family(this.idFamily, this.name, this.profile);
}

class settingPage extends StatefulWidget {
  settingPage({Key? key}) : super(key: key);

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  List<UserModel> userModels = [];
  String imageProfile =
      'https://firebasestorage.googleapis.com/v0/b/famfam-c881b.appspot.com/o/userProfile%2FcircleOnbg.png?alt=media&token=80bc8cea-30d6-41d7-8896-c86c021e059e';
  String? circle_id;
  String fname = "Loading...";
  String lname = "";

  @override
  void initState() {
    super.initState();
    pullUserSQLID().then((value) {
      imageProfile = userModels[0].profileImage;
      fname = userModels[0].fname;
      lname = userModels[0].lname;
    });
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
          SharedPreferences preferences = await SharedPreferences.getInstance();
          setState(() {
            userModels.add(model);
            circle_id = preferences.getString('circle_id');
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(FirebaseAuth.instance.currentUser),
                ),
              );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ListView(children: [
          Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleSetting(),
                  CreateAndJoinCircle(),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                        elevation: 0),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(imageProfile),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '  ${fname} ${lname}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey[500],
                        size: 25,
                      ),
                      Padding(padding: EdgeInsets.only(right: 35))
                    ]),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            userID: FirebaseAuth.instance.currentUser!.uid
                                .toString(),
                            circle_id: circle_id,
                            profileUser: 1,
                            profileMem: 0,
                            profileOwner: 0,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                        elevation: 0),
                    child: buttonSettings(
                        'assets/images/Privacy.png', "Change your password"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePassword(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                        elevation: 0),
                    child: buttonSettings('assets/images/Help.png', "Help"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HelpPage()));
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                        elevation: 0),
                    child: buttonSettings('assets/images/About.png', "About"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutPage()));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 30,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 235, 113, 104),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Please Confirm'),
                                    content:
                                        const Text('Are you going to Logout ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          AuthService().signOut(context);
                                        },
                                        child: const Text('Log Out'),
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
          )
        ]),
      ),
    );
  }

  Widget buttonSettings(
    String namepic,
    String nameicon,
  ) {
    return Row(children: [
      Container(
        child: Image.asset(namepic),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        '$nameicon',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      Spacer(),
      Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey[500],
        size: 25,
      ),
      Padding(padding: EdgeInsets.only(right: 35))
    ]);
  }
}
