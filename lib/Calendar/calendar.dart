// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names
import 'dart:convert';

import 'package:dio/dio.dart';

// import 'package:famfam/Calendar/event.dart';
// import 'package:famfam/Calendar/AddEvens.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/models/calendar_model.dart';
import 'package:famfam/services/auth.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// // ignore: unused_import
// import 'package:famfam/Calendar/calendar.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  late Map<DateTime, List<CalendarModel>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TimeOfDay? time = TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? time1 = TimeOfDay(hour: 12, minute: 12);
  bool isChecked = false;

  final TextEditingController _eventControllertitle = TextEditingController();
  final TextEditingController _eventControllerlocation =
      TextEditingController();
  final TextEditingController _eventControllernote = TextEditingController();
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    pullUserSQLID();
  }

  List<CalendarModel> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  final User user = FirebaseAuth.instance.currentUser!;
  double value = 0;
  final AuthService _auth = AuthService();

  void checkuserid() {
    print("#########" + userModels[0].uid);
    print(circleModels[0].circle_id);
    print(selectedEvents);
  }

  Future<Null> insertCalendar() async {}

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
    pullCircle();
  }

  Future<Null> pullCircle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String circle_id = preferences.getString('circle_id')!;
    String member_id = userModels[0].id!;
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

  Future<Null> pullCalendar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;

    String pullCalendar =
        '${MyConstant.domain}/famfam/getCalendarwhereUser.php?isAdd=true&id=$id';
    await Dio().get(pullCalendar).then((value) {
      for (var item in json.decode(value.data)) {
        CalendarModel model = CalendarModel.fromMap(json.decode(value.data));
        print("calendar title ==>> ${model.title}");
      }
    });
  }

  @override
  void dispose() {
    _eventControllertitle.dispose();
    _eventControllerlocation.dispose();
    _eventControllernote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: size.height * 0.12,
                width: size.width * 1,
                // ignore: use_full_hex_values_for_flutter_colors
                decoration: BoxDecoration(
                  color: Color(0xffff6e5c7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                  ),
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 390, top: 0),
                      child: IconButton(
                        icon: Icon(
                          IconData(0xf8f4,
                              fontFamily: 'MaterialIcons',
                              matchTextDirection: true),
                          color: Colors.black,
                          size: 45,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 215,
                        right: 0,
                      ),
                      child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.0596,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(0),
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, left: 60),
                          child: Text(
                            "Calendar",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TableCalendar(
                focusedDay: selectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekVisible: true,

                //Day Changed
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                  // ignore: avoid_print
                  print(focusedDay);
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },

                eventLoader: _getEventsfromDay,

                //To style the Calendar
                calendarStyle: CalendarStyle(
                  // isTodayHighlighted: true,
                  defaultTextStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  rowDecoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfffEBE9E9)))),
                  disabledTextStyle: TextStyle(fontSize: 16),
                  // outsideTextStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  weekendTextStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  cellPadding: EdgeInsets.all(12),
                  outsideDaysVisible: false,

                  selectedDecoration: BoxDecoration(
                    color: Color(0xfffFFC34A),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  todayTextStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  selectedTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  todayDecoration: BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown[800]),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(40),
                            bottomRight: Radius.circular(0))),
                    formatButtonShowsNext: false,
                    // formatButtonTextStyle: const TextStyle(
                    //   color: Colors.white,
                    // ),
                    headerMargin: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: Colors.white),
                  decoration: BoxDecoration(
                    color: Color(0xfffFFC34A),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
                daysOfWeekHeight: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    color: Color(0xffff6e5c7)),
                height: size.height * 0.43,
                child: DefaultTabController(
                  length: 2,
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 70,
                              child: TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Color(0xfffB5B0A2),
                                labelStyle: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w800),
                                unselectedLabelStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                indicator: BoxDecoration(),
                                tabs: [
                                  Tab(
                                    text: "Activities",
                                  ),
                                  Tab(
                                    text: "Repeat",
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: TabBarView(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        ..._getEventsfromDay(selectedDay).map(
                                          (CalendarModel event) => ListTile(
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 20, 5),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 1,
                                                        ),
                                                        child: Text(
                                                          '${time!.hour.toString()}:${time!.minute.toString()}',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 1,
                                                        ),
                                                        child: Text(
                                                          "${time1!.hour.toString()}:${time1!.minute.toString()}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: Container(
                                                      width: size.width * 0.7,
                                                      // height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfffE7C581),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        top: 6),
                                                                    child: Text(
                                                                        "",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: 19)),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 20,
                                                                      top: 6,
                                                                    ),
                                                                    child: Text(
                                                                      event
                                                                          .title,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //           .only(
                                                                  //     left: 20,
                                                                  //   ),
                                                                  //   child: Icon(
                                                                  //     IconData(
                                                                  //         0xe1b9,
                                                                  //         fontFamily:
                                                                  //             'MaterialIcons'),
                                                                  //     color: Color
                                                                  //         .fromARGB(
                                                                  //             255,
                                                                  //             211,
                                                                  //             11,
                                                                  //             11),
                                                                  //     size: 20,
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            28,
                                                                        top: 1,
                                                                        bottom:
                                                                            5),
                                                                    child: Icon(
                                                                      IconData(
                                                                          0xf009e,
                                                                          fontFamily:
                                                                              'MaterialIcons'),
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          245,
                                                                          245,
                                                                          245),
                                                                      size: 13,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 1,
                                                                        top: 0,
                                                                        bottom:
                                                                            5),
                                                                    child: Text(
                                                                      event
                                                                          .location,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Color(0xfff707070)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),

                                                          // Text(
                                                          //   event.locations,
                                                          // ),
                                                          // Text(
                                                          //   event.note,
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      // child: Padding(
                                      //   padding: const EdgeInsets.only(
                                      //     left: 20,
                                      //   ),
                                      //   child: Icon(
                                      //     IconData(0xe1b9,
                                      //         fontFamily: 'MaterialIcons'),
                                      //     color: Color.fromARGB(255, 211, 11, 11),
                                      //     size: 20,
                                      //   ),
                                      // ),
                                      )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xfffA2A2A2),
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              String contentText = "Content of Dialog";
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: Color(0xfffF6E5C7),
                  title: Column(
                    children: [
                      Container(
                        width: 500,
                        child: Container(
                          child: Text(
                            "Add Note",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Container(
                      width: size.width * 1,
                      height: size.height / 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Hour",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Minute",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    "Hour",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Minute",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 9, 10, 0),
                                  child: Container(
                                    height: size.height * 0.1 - 37,
                                    width: size.width * 0.02,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        TimeOfDay? time_start =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: time!,
                                        );
                                        if (time_start != null) {
                                          setState(() {
                                            time = time_start;
                                          });
                                        }
                                      },
                                      child: Text(
                                        '${time!.hour.toString()}:${time!.minute.toString()}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "OR",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 9, 10, 0),
                                  child: Container(
                                    height: size.height * 0.1 - 37,
                                    width: size.width * 0.02,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        TimeOfDay? time_end =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: time1!,
                                        );
                                        if (time_end != null) {
                                          setState(() {
                                            time1 = time_end;
                                          });
                                        }
                                      },
                                      child: Text(
                                        '${time1!.hour.toString()}:${time1!.minute.toString()}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Title",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: TextField(
                                  controller: _eventControllertitle,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    hintText: 'Write a title',
                                  ),
                                  autofocus: false,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: TextField(
                                  controller: _eventControllerlocation,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    hintText: 'Write the location',
                                  ),
                                  autofocus: false,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Note",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: TextField(
                                  controller: _eventControllernote,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    fillColor: Colors.white,
                                    hintText: 'Write your important note',
                                  ),
                                  autofocus: false,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.73,
                              decoration: BoxDecoration(
                                  color: Color(0xfffE7C581),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      "Repeating? ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Color.fromARGB(255, 170, 170, 170),
                      child: Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.amber,
                      child: Text('ADD'),
                      onPressed: () async {
                        if (_eventControllertitle.text.isEmpty) {
                        } else {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();

                          String user_id = userModels[0].id!;
                          String title = _eventControllertitle.text;
                          String note = _eventControllernote.text;
                          String location = _eventControllerlocation.text;
                          DateTime date = selectedDay;
                          TimeOfDay? time_start = time;
                          TimeOfDay? time_end = time1;
                          String repeating = '';
                          String circle_id =
                              preferences.getString('circle_id')!;
                          print(user_id);
                          print(circle_id);
                          String insertCalendar =
                              '${MyConstant.domain}/famfam/insertCalendarActivity.php?isAdd=true&title=$title&note=$note&location=$location&date=$date&time_start=$time_start&time_end=$time_end&repeating=$repeating&circle_id=$circle_id&user_id=$user_id';
                          await Dio().get(insertCalendar).then((value) async {
                            if (value.toString() == 'true') {
                              print('Insert  Successed');
                            }
                          });
                          print("checkinsert");
                          if (selectedEvents[selectedDay] != null) {
                            selectedEvents[selectedDay]?.add(
                              CalendarModel(
                                title: _eventControllertitle.text,
                                location: _eventControllerlocation.text,
                                note: _eventControllernote.text,
                                circle_id: preferences.getString('circle_id')!,
                                date: '',
                                repeating: '',
                                time_end: time.toString(),
                                time_start: time1.toString(),
                                user_id: userModels[0].id!,
                              ),
                            );
                            print(selectedDay);
                            print('check');
                          } else {
                            selectedEvents[selectedDay] = [
                              CalendarModel(
                                title: _eventControllertitle.text,
                                location: _eventControllerlocation.text,
                                note: _eventControllernote.text,
                                circle_id: preferences.getString('circle_id')!,
                                repeating: '',
                                date: '',
                                time_end: time.toString(),
                                time_start: time1.toString(),
                                user_id: userModels[0].id!,
                              )
                            ];
                          }
                        }
                        Navigator.pop(context);
                        _eventControllertitle.clear();
                        _eventControllerlocation.clear();
                        _eventControllernote.clear();

                        setState(() {});
                        isChecked = false;
                        return;
                      },
                    ),
                  ],
                );
              });
            }),
        // onPressed: () {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => AddEvens()));
        // },
        label: const Text(
          "Add",
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
