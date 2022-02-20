// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_famfam/constants.dart';
import 'package:flutter_famfam/screens/ticktik_screen.dart';
//import 'package:flutter_famfam/screens/circle_screen.dart';
import 'package:flutter_famfam/screens/todolist_screens.dart';
import 'package:flutter_famfam/screens/voterandom_screen.dart';

void main() {
  runApp(MyApp());
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
      //home: CircleScreen(),
      //home: ToDoListScreen(),
      //home: TickTikScreen(),
      home: VoteRandomScreen(),
    );
  }
}
