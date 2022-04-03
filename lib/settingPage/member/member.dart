import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/profile/Profile.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/service_locator.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Member {
  int owner;
  String name;
  String profile;
  Member(this.owner, this.name, this.profile);
}

class memberPage extends StatefulWidget {
  final String? circle_id;
  const memberPage({Key? key, this.circle_id}) : super(key: key);

  @override
  State<memberPage> createState() => _memberPageState();
}

class _memberPageState extends State<memberPage> {
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  List<UserModel> employeeModels = [];
  List<bool> hostChecked = [];

  String familyname = 'Loading...';

  String code = 'loading...';

  List<Member> member = [
    Member(1, 'Janejira', 'J-Profile.png'),
    Member(0, 'Burin', 'J-Profile.png'),
    Member(0, 'Nigron', 'J-Profile.png'),
    Member(0, 'Mia', 'J-Profile.png'),
    Member(0, 'Arunee', 'J-Profile.png'),
  ];

  @override
  void initState() {
    print(widget.circle_id);
    super.initState();
    pullUserSQLID().then((value) => pullCircle().then((value) {
          familyname = circleModels[0].circle_name;
          code = circleModels[0].circle_code;
        }).then((value) {
          pullEmployeeData().then((value) {
            checkingHost();
          });
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
    String? circle_id = widget.circle_id;
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

  Future<Null> pullEmployeeData() async {
    String? circle_id = widget.circle_id;
    String pullEmployee =
        '${MyConstant.domain}/famfam/getUserWhereCircleID.php?isAdd=true&circle_id=$circle_id';
    await Dio().get(pullEmployee).then((value) async {
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          employeeModels.add(model);
        });
      }
    });
  }

  checkingHost() {
    for (int i = 0; i <= employeeModels.length; i++) {
      if (employeeModels[i].id == circleModels[0].host_id) {
        hostChecked.add(true);
      } else {
        hostChecked.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            familyname,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => settingPage()));
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
              padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  Icon(Icons.search),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    'Search',
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 300,
              child: ListView.builder(
                  itemCount: employeeModels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return hostChecked[index] == true
                        ? Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                // locator<NavigationService>()
                                //     .navigateTo('members_in_circle_Member');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                      userID: employeeModels[index].uid,
                                      circle_id: circleModels[0].circle_id,
                                      profileUser: 0,
                                      profileMem: 0,
                                      profileOwner: 1,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFF7575),
                                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          employeeModels[index].profileImage),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          ),
                                          Text(
                                            'Owner',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        employeeModels[index].fname,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                // locator<NavigationService>()
                                //     .navigateTo('members_in_circle_Member');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                      userID: employeeModels[index].uid,
                                      circle_id: circleModels[0].circle_id,
                                      profileUser: 0,
                                      profileMem: 1,
                                      profileOwner: 0,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF80E28D),
                                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          employeeModels[index].profileImage),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.assignment_ind,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          ),
                                          Text(
                                            'Member',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        employeeModels[index].fname,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                    text: code,
                  ));
                  Fluttertoast.showToast(
                      msg: "Copied to clipboard.",
                      gravity: ToastGravity.BOTTOM);
                },
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Invite Code : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ],
        ),
      ),
    );
  }
}
