import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircleSetting extends StatefulWidget {
  @override
  State<CircleSetting> createState() => _CircleSettingState();
}

class _CircleSettingState extends State<CircleSetting> {
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  List<bool> currentCircle = [];

  @override
  void initState() {
    super.initState();
    pullUserSQLID().then(
      (value) => pullCircle().then(
        (value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? circle_id = preferences.getString('circle_id');
          CurrentCircleIsChecked(circle_id);
        },
      ),
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
    String? member_id = userModels[0].id;
    String pullCircle =
        '${MyConstant.domain}/famfam/getCircleWhereUserID.php?isAdd=true&member_id=$member_id';
    await Dio().get(pullCircle).then((value) async {
      for (var item in json.decode(value.data)) {
        CircleModel model = CircleModel.fromMap(item);
        setState(() {
          circleModels.add(model);
        });
      }
    });
  }

  CurrentCircleIsChecked(String? circle_id) {
    print(circleModels.length);
    for (int i = 0; i < circleModels.length; i++) {
      if (circleModels[i].circle_id == circle_id) {
        currentCircle.add(true);
      } else {
        currentCircle.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: circleModels.length,
          itemBuilder: (context, index) {
            return BuildCircle(
              circleModels: circleModels[index],
              currentCircle: currentCircle[index],
            );
          }),
    );
  }
}

class BuildCircle extends StatefulWidget {
  final CircleModel? circleModels;
  final bool? currentCircle;
  const BuildCircle({Key? key, this.circleModels, this.currentCircle})
      : super(key: key);

  @override
  State<BuildCircle> createState() => _BuildCircleState();
}

class _BuildCircleState extends State<BuildCircle> {
  List<UserModel> employeeModels = [];

  @override
  void initState() {
    super.initState();
    pullEmployeeData();
  }

  Future<Null> pullEmployeeData() async {
    String? circle_id = widget.circleModels!.circle_id;
    String pullEmployee =
        '${MyConstant.domain}/famfam/getUserWhereCircleID.php?isAdd=true&circle_id=$circle_id';
    await Dio().get(pullEmployee).then((value) async {
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          employeeModels.add(model);
        });
      }
      print(employeeModels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF141E27),
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: MediaQuery.of(context).size.width / 1.1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => memberPage(
                circle_id: widget.circleModels!.circle_id,
              ),
            ),
          );
          print(widget.circleModels!.circle_id);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Text(
                    widget.circleModels!.circle_name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Builder(builder: (context) {
                    if (widget.currentCircle == true) {
                      return Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Stack(
                              children: [
                                RoundCheckBox(
                                  isChecked: true,
                                  onTap: null,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  onPressed: () {
                                    {
                                      // ติ๊กถูก
                                      Fluttertoast.showToast(
                                          msg:
                                              "This Circle is already been chose.",
                                          gravity: ToastGravity.BOTTOM);
                                    }
                                  },
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Stack(
                              children: [
                                RoundCheckBox(
                                  isChecked: false,
                                  onTap: null,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  onPressed: () async {
                                    {
                                      // ติ๊กถูก
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      preferences
                                          .setString('circle_id',
                                              widget.circleModels!.circle_id!)
                                          .then(
                                        (value) async {
                                          Navigator.pop(context);
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  settingPage(),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
            Center(
              child: Divider(
                height: 20,
                thickness: 3,
                indent: 0,
                endIndent: 0,
                color: Colors.grey[400],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: 110,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: employeeModels.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                employeeModels[index].profileImage),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            employeeModels[index].fname,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
