import 'package:famfam/settingPage/privacy/changepass.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:flutter/widgets.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class PrivacyEZ extends StatefulWidget {
  @override
  State<PrivacyEZ> createState() => _PrivacyEZState();
}

class _PrivacyEZState extends State<PrivacyEZ> {
  bool statusEZ = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Privacy & EZ-Mode",
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
          // backgroundColor: Color(0xFFF6E5C7),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Text(
                  'Account Security',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500]),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      elevation: 0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                      ),
                      Text(
                        'Change your password',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(right: 20))
                    ],
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                      elevation: 0),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                      ),
                      Text(
                        'Delete your account',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                      Padding(padding: EdgeInsets.only(right: 20))
                    ],
                  )),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child: SwitchListTile(
                    title: const Text(
                      'EZ - Mode',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    value: statusEZ,
                    activeColor: Colors.green[800],
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.grey[500],
                    inactiveTrackColor: Colors.grey[300],
                    onChanged: (bool value) {
                      setState(() {
                        statusEZ = value;
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
