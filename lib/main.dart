// import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/Calendar/calendar.dart';
// import 'package:famfam/check-in/Checkin.dart';
// import 'package:famfam/check-in/menu.dart';
import 'package:famfam/welcome.dart';
import 'package:flutter/material.dart';
import 'package:famfam/register.dart';
import 'package:famfam/Calendar/event.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: Welcome()
      // home: HomeScreen()
      // home: Welcome()
      // home: CheckIn()
      home: Calendar(),
      // home: MenuCheckIn());)
    );
  }
}
