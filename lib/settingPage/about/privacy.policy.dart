import 'package:flutter/material.dart';
import 'package:famfam/settingPage/about/about.dart';

class Privacy_policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Privacy Policy",
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AboutPage()));
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.all(30),
          child: Text(
            "Flutter Text Overflow while adding long text. how to wrap text in flutter",
            maxLines: 3,
            overflow: TextOverflow.clip,
          )),
    ));
  }
}
