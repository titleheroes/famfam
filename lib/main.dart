// import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/login.dart';
// import 'package:famfam/check-in/Checkin.dart';
// import 'package:famfam/check-in/menu.dart';
import 'package:famfam/welcome.dart';
import 'package:flutter/material.dart';
import 'package:famfam/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        // home: Welcome()
        // home: HomeScreen()
        home: Welcome()
        // home: CheckIn()
        // home: MenuCheckIn());)
        );
  }
}
