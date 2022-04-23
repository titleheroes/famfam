// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
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
  List<CalendarModel> calendarModels = [];
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
    // print('........${selectedDay}');
    selectedEvents = {};
    super.initState();
    pullUserSQLID().then((value){
      pullCircle().then((value){
        pullCalendar();
      });
      
    });
    
  }

  List<CalendarModel> _getEventsfromDay(DateTime date) {
    
    return selectedEvents[date] ?? [
      
    ];
    
  }

  final User user = FirebaseAuth.instance.currentUser!;
  double value = 0;
  final AuthService _auth = AuthService();

  // void checkuserid() {
  //   print("#########" + userModels[0].uid);
  //   print(circleModels[0].circle_id);
  //   print(selectedEvents);
  // }

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

  Future<Null> pullCalendar() async {
    if(calendarModels.length != 0){
      calendarModels.clear();

    }else{}
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String circle_id = preferences.getString('circle_id')!;
    DateTime tempDate;

    String pullCalendar =
        '${MyConstant.domain}/famfam/getCalendarwhereCircle.php?isAdd=true&circle_id=$circle_id';
        try{
          await Dio().get(pullCalendar).then((value)  {
      // DateTime tempDate ;
      
      
      for (var item in json.decode(value.data)) {
        CalendarModel model = CalendarModel.fromMap(item);
        setState(() {
          calendarModels.add(model);
          tempDate = new DateFormat("yyyy-MM-dd").parse(model.date);
          tempDate = tempDate.toUtc();
          tempDate = tempDate.add(Duration(days: 1));
          tempDate = tempDate.subtract(Duration(hours: 17));
          
          
       
          // tempDate = model.date as DateTime ;
          if (selectedEvents[tempDate] != null) {
           selectedEvents[tempDate]?.add(
                                CalendarModel(
                                  id: model.id,
                                  title:model.title,
                                  location: model.location,
                                  note:model.note,
                                  circle_id: model.circle_id,
                                  date: model.date,
                                  repeating: '',
                                  time_end: model.time_end,
                                  time_start: model.time_start,
                                  user_id: model.user_id,
                                ),
                              );}
                              else{
                                selectedEvents[tempDate] = [
                                  CalendarModel(
                                  id: model.id,
                                  title:model.title,
                                  location: model.location,
                                  note:model.note,
                                  circle_id: model.circle_id,
                                  date: model.date,
                                  repeating: '',
                                  time_end: model.time_end,
                                  time_start: model.time_start,
                                  user_id: model.user_id,
                                ),

                                ];

                              }
                              // print(selectedEvents[tempDate]);
                              // print(model.date);
                              print(tempDate);
                              
                             
        });
        // print("calendar title ==>> ${model.title}");
         
      }
    });
        }catch(e){}
    
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user)));
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
              Builder(
                builder: (context) {
                  for(int i = 0 ;CalendarModel==[];i++){
                    sleep(Duration(seconds: 1));

                  }
                  return TableCalendar(
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
                      print(selectedDay);
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
                  );
                }
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
                    child: Column(
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
                                  // Container(
                                  //   child: Column(
                                  //     children: [
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                   
                                 LayoutBuilder(builder: (context, constraints) =>BuildListView(constraints),),
                                  Container()
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
                return MaterialApp(
                  builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child?? Container()),
                  home : AlertDialog(
                    
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                 
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text(
                                      "Start",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Color.fromARGB(255, 71, 71, 71)),
                                    ),
                                  ),
                                 
                                  Padding(
                                    padding: const EdgeInsets.only(left: 125),
                                    child: Text(
                                      "End",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Color.fromARGB(255, 71, 71, 71)),
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
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time!,
                                            builder: (context, child){
                                              return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child : child?? Container())
                                            }
                                          );
                                          if (newTime != null) {
                                            setState(() {
                                              time = newTime;
                                              
                                            });
                                            print(time);
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
                                          TimeOfDay? newTime1 =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time1!,
                                            builder: (context, child){
                                              return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child : child?? Container())
                                            }
                                          );
                                          if (newTime1 != null) {
                                            setState(() {
                                              time1 = newTime1;
                                              
                                            });
                                            print(time1);
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
                                  height: 60,
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
                         
                          if (_eventControllertitle.text.isEmpty )  {
                            
                            Fluttertoast.showToast(msg: "Can't add activity because you did not input 'title' !", gravity: ToastGravity.BOTTOM);

                          } else if( _eventControllerlocation.text.isEmpty ){
                            Fluttertoast.showToast(msg: "Can't add activity because You did not input 'location' !", gravity: ToastGravity.BOTTOM);

                          }
                          else {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                
                            String user_id = userModels[0].id!;
                            String title = _eventControllertitle.text;
                            String note = _eventControllernote.text;
                            String location = _eventControllerlocation.text;
                            String date = selectedDay.toString();
                            var replacingTime = time!.replacing(
                            hour:time!.hour,
                            minute: time!.minute);
                            String? time_start = replacingTime.hour.toString() +
                                ":" +
                                replacingTime.minute.toString();
                            var replacingTime1 = time1!.replacing(
                            hour:time1!.hour,
                            minute: time1!.minute);
                            String? time_end = replacingTime1.hour.toString() +
                                ":" +
                                replacingTime1.minute.toString();
                          
                            String repeating = '';
                            String circle_id =
                                preferences.getString('circle_id')!;
                                 DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDay.toString());
                            print(user_id);
                            print(circle_id);
                            print(time_start);
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
                                  date: selectedDay.toString(),
                                  repeating: '',
                                  time_end: time_end.toString(),
                                  time_start: time_start.toString(),
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
                                  date: selectedDay.toString(),
                                  time_end: time_end.toString(),
                                  time_start: time_start.toString(),
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
                          
                          await Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Calendar(),
                                            ),
                                          );
                                          return;
                        },
                      ),
                    ],
                  ),
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

  Container BuildListView(BoxConstraints constraints) {
    // DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDay.toString());
   
    // tempDate = tempDate.toUtc();
    // tempDate = tempDate.subtract(Duration(hours: 17));
    Size size = MediaQuery.of(context).size;
    print(selectedEvents[selectedDay]);
    for(int i = 0;selectedEvents[selectedDay]==null;i++){
     
      if(i== 3){
        break;
      }
    }
   

    
      return selectedEvents[selectedDay] == null?
      Container(

      ):Container(
       

        child: ListView.builder(itemCount: selectedEvents[selectedDay]?.length, itemBuilder: ((context, index) =>
        
     Row(
        
        children: [
           
            //  ..._getEventsfromDay(selectedDay).map(
            //                               (CalendarModel event) => 
          
              Container(
                
                margin: EdgeInsets.only(bottom: index == selectedEvents[selectedDay]!.length-1 ? 230 :10),
                child: Padding(
                    
                                                padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                                                //margin: EdgeInsets.only(bottom: 50),
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
                                                            // calendarModels[index].time_start,
                                                            selectedEvents[selectedDay]![index].time_start,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 1,
                                                          ),
                                                          child: Text(
                                                           selectedEvents[selectedDay]![index].time_end,
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
                                                        // 
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xfffE7C581),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                         child: ExpansionTile(
        title: Column(
                                                          children: [
                                                            
                                                          Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left: 5,
                                                                          top: 6),
                                                                  child: Text("",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w400,
                                                                          fontSize:
                                                                              19)),
                                                                ),
                                                                Flexible(
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 20,
                                                                      top: 6,
                                                                      right: 5,
                                                                    ),
                                                                    child: Text(
                                                                      selectedEvents[selectedDay]![index].title,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
                                                                          color: Colors
                                                                              .black),
                                                                    ),
                                                                  ),
                                                                ),
                                                                 
                                                              ],
                                                          
                                                            ),
                                                                
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              28,
                                                                          top: 5,
                                                                          right:
                                                                              7,
                                                                              ),
                                                                  child: Icon(
                                                                    IconData(
                                                                        0xf009e,
                                                                        fontFamily:
                                                                            'MaterialIcons'),
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            245,
                                                                            245,
                                                                            245),
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                                 Flexible(
                                                                        child:   Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left: 1,
                                                                          top: 5,
                                                                          bottom:
                                                                              5),
                                                                  child: Text(
                                                                    selectedEvents[selectedDay]![index].location,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Color(
                                                                            0xfff707070)),
                                                                  ),
                                                                ),
                                                                  ),
                                                                 
                                                             
                                                              ],
                                                            ),
                                                            
                                                          ],),
                                                          children:
                                                           <Widget>[
                                                        ListTile(
                                                          title: 
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            30,
                                                                        right: 1,
                                                                        bottom:
                                                                            10),
                                                                child:
                                                                (selectedEvents[selectedDay]![index]
                                                                          .note.isEmpty)
                                            ? Column(children: [
                                                
                                                
                                               Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          123,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2)),
                                                                  width:
                                                                      size.width *
                                                                          0.44,
                                                                  child:
                                                                  Flexible(
                                                                      child:Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            9.0),
                                                                    child: Text(
                                                                      "You didn't write a note!!",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              83,
                                                                              83,
                                                                              83)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                
                                                                ),
                                              ])
                                              :Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromARGB(
                                                                          123,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2)),
                                                                  width:
                                                                      size.width *
                                                                          0.44,
                                                                  child:
                                                                  Flexible(
                                                                      child:Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            9.0),
                                                                    child: Text(
                                                                      selectedEvents[selectedDay]![index]
                                                                          .note,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              83,
                                                                              83,
                                                                              83)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                
                                                                ),

                                                            
                                                              
                                                                
                                                              ),
                                                              IconButton(
                                                                      onPressed:
                                                                       () {
                                                                         print('### click delete from index = $index');
                                                                         _confirmDialogDelete(selectedEvents[selectedDay]![index].id.toString());
                                                                     
                                                                       },
                                                                      icon: SvgPicture.asset(
                                                                      "assets/icons/trash.svg",
                                                                        height: 20,
                                                                        ),
                                                                    ),],
                                                              
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
         
                                          // )
        ],
       )
                                        
                                        
                                    ),
                                  ),
      );

    
    
                                
                                
  }
  
  // Future<Null> confirmDialogDelete(int index) async{
    
    // showDialog(context: context, builder: (context) =>AlertDialog(
    //   title: ListTile(leading: Text('Do you want to delete  "${selectedEvents[selectedDay]![index].title}"  ?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      
    // ),actions: [FlatButton(
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(10))),
    //                     color: Color.fromARGB(255, 246, 135, 65),
    //                     child: Text('Delete'),
    //                     onPressed: () async {
    //                       print(selectedEvents[selectedDay]![index].id);
    //                       String? id = selectedEvents[selectedDay]![index].id;
    //                       print('## confirm delete at id  = ${selectedEvents[selectedDay]![index].id}');
    //                       String apiDeleteCalendarwhereId = '${MyConstant.domain}/famfam/deleteCalendarActivity.php?isAdd=true&id=$id';
    //                       await Dio().get(apiDeleteCalendarwhereId).then((value) async {
    //                         Navigator.pop(context);
    //                         await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Calendar()));
    //                         // pullCalendar();
                            

    //                       });

                          
    //                     },
    //                   ),
    // FlatButton(
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(10))),
    //                     color: Color.fromARGB(255, 170, 170, 170),
    //                     child: Text('Cancel'),
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                     },
    //                   ),],

      
    // ),);

  // }



    Future<void> _confirmDialogDelete(String id) async {
    
         showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove this activity?'),
            actions: [
             
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
               // The "Yes" button
              CupertinoDialogAction(
                onPressed: () async{
                 
             
                        DeleteCalendarActivity(id);
                        //onDismissed();
                        Navigator.pop(context);
                             await Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Calendar(),
                                            ),
                                          );
                            
                 
                 
                },
                child: const Text('Delete'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
            ],
          );
        });

    

      
  }

  void DeleteCalendarActivity(String id)async {
    
    String cid = id;
    String DeleteCalendarActivity = '${MyConstant.domain}/famfam/deleteCalendarActivity.php?isAdd=true&id=$id' ;
    
    print('## target = $cid');

    await Dio().get(DeleteCalendarActivity).then((value) {
      if(value.toString()=='True'){
        print('Activity Deleted');
      }else{
        print('Delete Error');
      }
    });
    //Navigator.pushNamed(context, '/pinpost');
    // getPinpostFromCircle();

  }
}

