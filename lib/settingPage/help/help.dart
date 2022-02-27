import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:flutter/widgets.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Help",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settingPage()));
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
