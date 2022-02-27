import 'package:famfam/settingPage/about/privacy.policy.dart';
import 'package:famfam/settingPage/about/term_of_ser.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:flutter/widgets.dart';

class AboutPage extends StatelessWidget {
  String version = '1.0.0 build A';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "About",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Row(children: [
                Text(
                  'Current version',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Spacer(),
                Text(
                  version,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Padding(padding: EdgeInsets.only(right: 20))
              ]),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  elevation: 0),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermPage()));
              },
              child: Row(children: [
                Text(
                  'Term and Conditions of Use',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey[500],
                  size: 30,
                ),
                Padding(padding: EdgeInsets.only(right: 20))
              ]),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  elevation: 0),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Privacy_policy()));
              },
              child: Row(children: [
                Text(
                  'Pricacy Policy',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey[500],
                  size: 30,
                ),
                Padding(padding: EdgeInsets.only(right: 20)),
              ]),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  elevation: 0),
            ),
          ],
        ),
      ),
    );
  }
}
