import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/services/auth.dart';
import 'package:famfam/settingPage/circle/circle.dart';
import 'package:famfam/settingPage/create&join/create&join.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/profile/Profile.dart';
import 'package:famfam/settingPage/about/about.dart';
import 'package:famfam/settingPage/help/help.dart';
import 'package:famfam/settingPage/notification/notification.dart';
import 'package:famfam/settingPage/privacy/Privacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  List<String> circle = [
    'one Family',
    'two Family',
    'three Family',
    'four Family'
  ];

  List<Family> circle01 = [
    Family('one', 'Janejira', 'J-Profile.png'),
    Family('one', 'Burin', 'J-Profile.png'),
    Family('one', 'Martin', 'J-Profile.png'),
    Family('one', 'Arunee', 'J-Profile.png')
  ];

  @override
  Widget build(BuildContext context) {
    int length = circle.length;
    String family = 'Sabaidee';
    String imageProfile = 'assets/images/J-Profile.png';

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
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
                              HomePage(FirebaseAuth.instance.currentUser)));
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                            elevation: 0),
                        child: buttonSettings(imageProfile, "My Profile"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(
                                        profileUser: 1,
                                        profileMem: 0,
                                        profileOwner: 0,
                                      )));
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
                            'assets/images/Privacy.png', "Privacy & EZ-Mode"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyEZ()));
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                            elevation: 0),
                        child: buttonSettings(
                            'assets/images/Notification.png', "Notification"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationPage()));
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                            elevation: 0),
                        child: buttonSettings('assets/images/Help.png', "Help"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HelpPage()));
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                            elevation: 0),
                        child:
                            buttonSettings('assets/images/About.png', "About"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()));
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 5.5,
                            top: 20,
                            bottom: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFE3E3E3),
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              elevation: 0),
                          child: Text(
                            "Log out",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            AuthService().signOut(context);
                          },
                        ),
                      ),
                    ]),
              )
            ])));
  }

  Widget buttonSettings(
    String namepic,
    String nameicon,
  ) =>
      Row(children: [
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
