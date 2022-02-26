// ignore_for_file: prefer_const_constructors

import 'package:famfam/constants.dart';
import 'package:famfam/screens/ticktik_screen.dart';
//import 'package:flutter_famfam/screens/circle_screen.dart';
import 'package:famfam/screens/todolist_screens.dart';
import 'package:famfam/screens/voterandom_screen.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/Homepage/addList.dart';
import 'package:famfam/check-in/Checkin.dart';
import 'package:famfam/loading.dart';
import 'package:famfam/login.dart';
import 'package:famfam/register_info.dart';
import 'package:famfam/welcome.dart';
import 'package:flutter/material.dart';
import 'package:famfam/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:famfam/pinpost_screen/pin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/welcome': (context) => Welcome(),
        '/register': (context) => Register(),
        '/registerinfo': (context) => Register_Info(),
        '/login': (context) => Login(),
        '/ticktik': (context) => TickTikScreen(),
        '/todolist': (context) => ToDoListScreen(),
        '/voterandom': (context) => VoteRandomScreen(),
        '/checkin': (context) => CheckIn(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fam app",
      theme: ThemeData(
        scaffoldBackgroundColor: wBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomeScreen()
      // home: PinScreen()
      // home: CheckIn()
      // home: MenuCheckIn());)
      //home: CircleScreen(),
      //home: ToDoListScreen(),
      //home: TickTikScreen(),
      home: VoteRandomScreen(),
    );
  }
}
