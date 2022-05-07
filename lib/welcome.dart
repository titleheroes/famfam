import 'package:carousel_slider/carousel_slider.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/login.dart';
import 'package:famfam/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/auth.dart';

import 'dart:async';

class Welcome extends StatefulWidget {
  @override
  _Welcome1State createState() => _Welcome1State();
}

class list_welcome {
  String text1;
  String text2;
  String image;
  list_welcome(this.text1, this.text2, this.image);
}

class _Welcome1State extends State<Welcome> {
  int _current = 0;
  final AuthService _auth = AuthService();
  final CarouselController _controller = CarouselController();

  List<list_welcome> image = [
    list_welcome('Enjoy your day', 'Manage your life!',
        'assets/images/Welcome-1ToDoList.png'),
    list_welcome('Never forget', 'Have fun with task!',
        'assets/images/Welcome-2Task.png'),
    list_welcome('Keep Fam know', 'Throw yourself!',
        'assets/images/Welcome-3Checkin.png')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Expanded(
              child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height - 60,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: image
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                SafeArea(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                      ),
                                      Text(
                                        e.text1,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Merriweather"),
                                      ),
                                      Text(
                                        e.text2,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Merriweather"),
                                      ),
                                      Container(
                                        child: Image.asset(e.image),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList()),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: Colors.orange.shade300,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Get Start!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Merriweather"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: image.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.orange)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
