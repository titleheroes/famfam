// import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/HomeScreen.dart';
// import 'package:famfam/check-in/Checkin.dart';
// import 'package:famfam/check-in/menu.dart';
import 'package:famfam/welcome.dart';
import 'package:flutter/material.dart';
import 'package:famfam/register.dart';
import 'package:famfam/pinpost_screen/pin_screen.dart';

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
          primarySwatch: Colors.deepOrange,
        ),
        
        // home: HomeScreen()
        home: PinScreen()
        // home: CheckIn()
        // home: MenuCheckIn());)
        );
  }
}
