import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                "Contact Us",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(
                  text: '+66 98 897 9131',
                ));
                Fluttertoast.showToast(
                    msg: "Copied to clipboard.", gravity: ToastGravity.BOTTOM);
              },
              child: Row(children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.call,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(
                  width: 35,
                ),
                Text(
                  'Call',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Spacer(),
                Text(
                  '+66 98 897 9131',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Padding(padding: EdgeInsets.only(right: 20))
              ]),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  elevation: 0),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(
                  text: 'wutthipat.tortlew@gmail.com',
                ));
                Fluttertoast.showToast(
                    msg: "Copied to clipboard.", gravity: ToastGravity.BOTTOM);
              },
              child: Row(children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.email,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(
                  width: 35,
                ),
                Text(
                  'E-mail',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Spacer(),
                Text(
                  'wutthipat.tortlew@gmail.com',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Padding(padding: EdgeInsets.only(right: 20))
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
