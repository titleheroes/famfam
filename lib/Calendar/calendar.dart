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
  
  bool calendar_load= true;
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
  bool repeat_selected = false;
  DateTime? newdate;
  
  String _dateTime = 'Select day';
  final TextEditingController _eventControllertitle = TextEditingController();
  final TextEditingController _eventControllerlocation =
      TextEditingController();
  final TextEditingController _eventControllernote = TextEditingController();
  @override
  void initState() {
    // print('........${selectedDay}');
    selectedEvents = {};
    super.initState();
    pullUserSQLID().then((value){pullCircle().then((value){ 
      
      setState(() {
        pullCalendar().then((value) => calendar_load= false);
      });
      
      
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

  Future<Null> pullCalendarRepeating() async {

    
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

  Future<Null> pullCalendar() async {

    setState(() {
      calendar_load= true;
      selectedEvents.clear();
    });
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
            
            setState(() {
              selectedEvents[tempDate]?.add(
                                CalendarModel(
                                  id: model.id,
                                  title:model.title,
                                  location: model.location,
                                  note:model.note,
                                  circle_id: model.circle_id,
                                  date: model.date,
                                  repeating: model.repeating,
                                  repeat_end_date : model.repeat_end_date,
                                  time_end: model.time_end,
                                  time_start: model.time_start,
                                  user_id: model.user_id,
                                ),
                              );
            });
           }else{
                                selectedEvents[tempDate] = [
                                  CalendarModel(
                                  id: model.id,
                                  title:model.title,
                                  location: model.location,
                                  note:model.note,
                                  circle_id: model.circle_id,
                                  date: model.date,
                                  repeating: model.repeating,
                                  repeat_end_date : model.repeat_end_date,
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
        }catch(e){
          setState(() {
            calendar_load= false;
          });
        }
    
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays + 1; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
      
      return days;
  }

   

  Future<void> insert_act(String title, String note, String location) async{
    setState () {
      calendar_load= true;
    }
      SharedPreferences preferences =
          await SharedPreferences.getInstance();

      String user_id = userModels[0].id!;
      
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
    

      String repeating = '0';
      String repeat_end_date = 'null';
      String circle_id = preferences.getString('circle_id')!;
      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDay.toString());
      String insertCalendar = '${MyConstant.domain}/famfam/insertCalendarActivity.php?isAdd=true&title=$title&note=$note&location=$location&date=$tempDate&time_start=$time_start&time_end=$time_end&repeating=$repeating&repeat_end_date=$repeat_end_date&circle_id=$circle_id&user_id=$user_id';
      await Dio().get(insertCalendar).then((value) async {
        if (value.toString() == 'true') {
          print('Insert  Successed');
         
        }else{
          print('Insert  failed');
        }

      });

  }


  Future<void> insert_repeat(String calendar_title,String calendar_location, String calendar_note) async{
        
        setState(() {
          calendar_load= true;
        });
        
        SharedPreferences preferences = await SharedPreferences.getInstance();
            
        String user_id = userModels[0].id!;
        String title = calendar_title;
        String note = calendar_note;
        String location = calendar_location;
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
      
        String repeating = '1';
        String repeat_end_date = _dateTime;

        List repeat_series = getDaysInBetween(selectedDay, newdate!);
        print(repeat_series);

        String circle_id = preferences.getString('circle_id')!;
        DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(selectedDay.toString());
        



      for(int i = 0;i<repeat_series.length;i++){

          String target_day = repeat_series[i].toString();
          DateTime retempDate = new DateFormat("yyyy-MM-dd").parse(target_day);
          String insertCalendar =
            '${MyConstant.domain}/famfam/insertCalendarActivity.php?isAdd=true&title=$title&note=$note&location=$location&date=$retempDate&time_start=$time_start&time_end=$time_end&repeating=$repeating&repeat_end_date=$repeat_end_date&circle_id=$circle_id&user_id=$user_id';
        


        await Dio().get(insertCalendar).then((value) async {
          if (value.toString() == 'true') {
            print('Insert  Successed index: '+i.toString());
          }else{
            print('Insert failed');
          }

        });

      }
      

        

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
      body: calendar_load? CircleLoader() : ListView(
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
                          const IconData(0xf8f4,
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
                      print('FocusedDay =====>>>'+focusedDay.toString());
                      print('SelectedDay =========>>>'+selectedDay.toString());
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

                                 Container(
                                   //color: Colors.blue,
                                   child: LayoutBuilder(builder: (context, constraints) =>BuildListView(constraints),)
                                  ),

                                
                                 Container(
                                    //color: Colors.red,
                                    child: LayoutBuilder(builder: (context, constraints) =>BuildRepeatListView(constraints),)
                                  )
                                ],
                              ),
                            ),
                            


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
      
      floatingActionButton: calendar_load? null : FloatingActionButton.extended(
        backgroundColor: Color(0xfffA2A2A2),
        onPressed: () =>  showDialog(
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
                                  "To",
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
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Need Repeating? ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                                                                                 Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                              ),
                             
                              StatefulBuilder(builder: (context, setState)
    {

                                  return Container(
                                    
                                    child: ElevatedButton(
                                      child: Text(_dateTime,style: TextStyle(color: Color.fromARGB(255, 55, 55, 55)),),
                                      style: ButtonStyle(
                                        backgroundColor:MaterialStateProperty.all<Color>(Color.fromARGB(255, 251, 229, 190)) ,
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                  ))),
                                      onPressed: () async {
                                        final initialDate = selectedDay;
                                          final nextDate = selectedDay.add(new Duration(days:1));
                                          
                                          final newDates = await showDatePicker(
                                              context: context,
                                              initialDate: nextDate,
                                              firstDate: nextDate ,
                                              lastDate: DateTime(2100));

                                          if (newDates == null) return;
                                          setState(() {
                                            _dateTime = DateFormat('dd-MM-yyyy').format(newDates);
                                            repeat_selected = true;
                                            newdate = newDates;
                                            /*
                                            print('repeat_selected ========>>>> '+repeat_selected.toString());
                                            print('Picking ========>>>>> ' + _dateTime.toString());
                                            */
                                            
                                          });

                                          getDaysInBetween(selectedDay, newDates);
                                          print(getDaysInBetween(selectedDay, newDates));

                                      }
                                      
                                    ),
                                  );
                                }
                              ),
                            ],
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
                        onPressed: () async{
                          setState(() {
                                            _dateTime = 'Select Date';
                                            
                                            
                                          });
                          repeat_selected = false;
                          print('repeat_selected =========>>>> '+repeat_selected.toString());
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
                          else if(repeat_selected.toString() == 'false') {
                            setState (() {
                              calendar_load= true;
                            },);
                            String title = _eventControllertitle.text;
                            String note = _eventControllernote.text;
                            String location = _eventControllerlocation.text;
                            insert_act(title,note,location).then((value) => pullCalendar().then((value) => calendar_load= false));
                            

                          }else if(repeat_selected.toString() == 'true'){
                            
                            setState (() {
                              calendar_load= true;
                            },);
                            insert_repeat(_eventControllertitle.text, _eventControllerlocation.text, _eventControllernote.text)
                            .then((value) => pullCalendar().then((value) => calendar_load= false).then((value) => repeat_selected = false).then((value) => _dateTime = 'Select Date'));
                            


                          }


                          Navigator.pop(context);
                          
                          _eventControllertitle.clear();
                          _eventControllerlocation.clear();
                          _eventControllernote.clear();
                
                          
                          // setState(() {
                          //   calendar_load= true;
                          // });
                          

                          isChecked = false;

                          /*
                          sleep(Duration(seconds:3));
                          await Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Calendar(),
                                            ),
                          );
                          */


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

  Container BuildRepeatListView(BoxConstraints constraints) {
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
              selectedEvents[selectedDay]![index].repeating == '0' ? Container() :
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
                                                                    const IconData(
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
                                                                         print('### click delete from index = ' + selectedEvents[selectedDay]![index].id.toString());
                                                                         print('### Repeating status = ' + selectedEvents[selectedDay]![index].repeating.toString());
                                                                         if(selectedEvents[selectedDay]![index].repeating.toString() == '0'){
                                                                              _confirmDialogDelete(selectedEvents[selectedDay]![index].id.toString());
                                                                         }else{

                                                                            String re_id = selectedEvents[selectedDay]![index].id.toString();                                                         
                                                                            String re_title = selectedEvents[selectedDay]![index].title.toString();
                                                                            String re_location = selectedEvents[selectedDay]![index].location.toString();
                                                                            String re_endDate = selectedEvents[selectedDay]![index].repeat_end_date.toString();
                                                                            String re_note = selectedEvents[selectedDay]![index].note.toString();

                                                                            print('### Title status = ' + re_title);
                                                                            print('### Location status = ' + re_location);
                                                                            print('### Note status = ' + re_note);
                                                                            print('### end date status = ' + re_endDate);

                                                                           _confirmRepeatDialogDelete(re_id, re_title, re_location, re_note, re_endDate);

                                                                         }
                                                                         
                                                                     
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
              selectedEvents[selectedDay]![index].repeating == '1' ? Container() :
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
                                                                    const IconData(
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
                                                                         print('### click delete from index = ' + selectedEvents[selectedDay]![index].id.toString());
                                                                         print('### Repeating status = ' + selectedEvents[selectedDay]![index].repeating.toString());
                                                                         if(selectedEvents[selectedDay]![index].repeating.toString() == '0'){
                                                                              _confirmDialogDelete(selectedEvents[selectedDay]![index].id.toString());
                                                                         }else{

                                                                            String re_id = selectedEvents[selectedDay]![index].id.toString();                                                         
                                                                            String re_title = selectedEvents[selectedDay]![index].title.toString();
                                                                            String re_location = selectedEvents[selectedDay]![index].location.toString();
                                                                            String re_endDate = selectedEvents[selectedDay]![index].repeat_end_date.toString();
                                                                            String re_note = selectedEvents[selectedDay]![index].note.toString();

                                                                            print('### Title status = ' + re_title);
                                                                            print('### Location status = ' + re_location);
                                                                            print('### Note status = ' + re_note);
                                                                            print('### end date status = ' + re_endDate);

                                                                           _confirmRepeatDialogDelete(re_id, re_title, re_location, re_note, re_endDate);

                                                                         }
                                                                         
                                                                     
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
    
  }

  Future<void> _confirmRepeatDialogDelete(String re_id, String re_title, String re_location, String re_note, String re_endDate) async {
    
         showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove this repeat activity?'),
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
                 
             
                        DeleteCalendarRepeatActivity(re_title,re_location,re_note,re_endDate);
                        
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
                child: const Text('Confirm'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
            ],
          );
        });

  }

  void DeleteCalendarRepeatActivity(String re_title, String re_location, String re_note, String re_endDate)async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String circle_id = preferences.getString('circle_id')!;

    String DeleteCalendarRepeatActivity = '${MyConstant.domain}/famfam/deleteCalendarRepeatActivity.php?isAdd=true&circle_id=$circle_id&title=$re_title&location=$re_location&note=$re_note&repeat_end_date=$re_endDate' ;
    
    

    await Dio().get(DeleteCalendarRepeatActivity).then((value) {
      if(value.toString()=='True'){
        print('Activity Deleted');
      }else{
        print('Delete Error');
      }
    });
    
  }




}