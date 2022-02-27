import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:flutter/widgets.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool statusNoti = false;
  bool statusTodo = false;
  bool statusEvent = false;
  bool statusCheck = false;
  bool statusQuest = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Notification",
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
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SwitchListTile(
                title: const Text('Notification'),
                value: statusNoti,
                activeColor: Colors.green[800],
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.grey[500],
                inactiveTrackColor: Colors.grey[300],
                onChanged: (bool value) {
                  setState(() {
                    statusNoti = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('To do list'),
                value: statusTodo,
                activeColor: Colors.green[800],
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.grey[500],
                inactiveTrackColor: Colors.grey[300],
                onChanged: (bool value) {
                  setState(() {
                    statusTodo = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Event'),
                value: statusEvent,
                activeColor: Colors.green[800],
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.grey[500],
                inactiveTrackColor: Colors.grey[300],
                onChanged: (bool value) {
                  setState(() {
                    statusEvent = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Check - In'),
                value: statusCheck,
                activeColor: Colors.green[800],
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.grey[500],
                inactiveTrackColor: Colors.grey[300],
                onChanged: (bool value) {
                  setState(() {
                    statusCheck = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Quest'),
                value: statusQuest,
                activeColor: Colors.green[800],
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.grey[500],
                inactiveTrackColor: Colors.grey[300],
                onChanged: (bool value) {
                  setState(() {
                    statusQuest = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
