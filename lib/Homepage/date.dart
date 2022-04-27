import 'dart:math';

import 'package:famfam/Homepage/tabbar.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/widgets/circle_loader.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/models/calendar_model.dart';
import 'package:famfam/services/auth.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Date extends StatefulWidget {
  const Date({Key? key}) : super(key: key);

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  bool load = true;
  bool calendarHaveData = false;
  List<CalendarModel> calendarModels = [];
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  String title = 'loading...';
  String location = 'loading...';
  String time_start = '-';
  String time_end = '-';

  void initState() {
    // print('........${selectedDay}');

    super.initState();
    pullUserSQLID().then((value) {
      pullCircle().then((value) {
        pullalendar().then((value) => {
              title = calendarModels[0].title,
              location = calendarModels[0].location,
              time_start = calendarModels[0].time_start,
              time_end = calendarModels[0].time_end,
            });
      });
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

  Future<Null> pullalendar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print('aaa' + formattedDate); // 2016-01-25

    String pullalendar =
        '${MyConstant.domain}/famfam/getCalendarwhereDate.php?isAdd=true&circle_id=$circle_id&date=$formattedDate';

    await Dio().get(pullalendar).then((value) async {
      if (value.toString() == 'null') {
        print('Today has no data');
      } else {
        for (var item in json.decode(value.data)) {
          CalendarModel model = CalendarModel.fromMap(item);
          setState(() {
            calendarModels.add(model);
            calendarHaveData = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFF9EE6D),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/calendar');
              },
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        child: Text(
                          DateFormat('EEEE').format(date),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.red),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        child: Text(DateFormat('d').format(date),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    Container(
                      child: Text(
                        DateFormat('MMMM, yyyy').format(date),
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //end date
          //line
          const VerticalDivider(
            width: 20,
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
            color: Color(0xfff707070),
          ),
          //end line

          //แจ้งเตือน

          Container(
            width: 200,
            padding: EdgeInsets.only(
              left: 4,
              top: 8,
            ),
            child: Expanded(
                child: Container(
              //color: Colors.red,

              child: (calendarHaveData)
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: calendarModels.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 55,
                            margin: EdgeInsets.only(bottom: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 8, 5),
                                  child: Text(
                                    calendarModels[index].title,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Icon(
                                        IconData(
                                          0xe3ab,
                                          fontFamily: 'MaterialIcons',
                                        ),
                                        color: Colors.yellow,
                                        size: 15,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Container(
                                        //color: Colors.blue,
                                        width: 60,
                                        child: Text(
                                          calendarModels[index].location,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      IconData(
                                        0xe738,
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      color: Colors.yellow,
                                      size: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Text(
                                        calendarModels[index].time_start +
                                            ' - ' +
                                            calendarModels[index].time_end,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      },
                    )
                  : Center(
                      child: Text(
                      "You don't have activity today",
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.w500),
                    )),
            )),
          )
        ],
      ),
    );
  }
}
