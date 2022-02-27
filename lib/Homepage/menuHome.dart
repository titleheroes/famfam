import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/check-in/Checkin.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFFE7C581);

class menuHome extends StatefulWidget {
  @override
  State<menuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<menuHome> {
  final User user = FirebaseAuth.instance.currentUser!;
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 160, top: 200),
        child: Container(
            // alignment: Alignment.centerLeft,

            child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(user),
                  ),
                );
              },
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/pinpost');
              },
              leading: Icon(
                Icons.note_rounded,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Pin Post",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/checkin');
              },
              leading: Icon(
                Icons.gps_fixed,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Check-In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ('/voterandom'));
              },
              leading: Icon(
                Icons.casino,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Vote & Rand",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.wallet_giftcard_rounded,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Rewardory",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => settingPage()));
              },
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 35,
              ),
              title: Text(
                "Setting",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        )));
  }
}
