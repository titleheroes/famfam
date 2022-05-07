import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/register.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPass extends StatefulWidget {
  ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final AuthService _auth = AuthService();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height) / 2.5,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Image.asset('assets/images/home.png'),
                      height: 200,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "F a m - F a m",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: (MediaQuery.of(context).size.height) - 1.74,
                  decoration: BoxDecoration(
                      color: Color(0xFFF1E5BA),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF1E5BA).withOpacity(0.35),
                          spreadRadius: -18,
                          offset: Offset(0, -40),
                        )
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(50, 30, 0, 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Let's recover your password",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sound You've worried.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "But don't We'll help you.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      //Email
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 00),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail address',
                            prefixIcon: Icon(Icons.email),
                            fillColor: Colors.white.withOpacity(0.8),
                            filled: true,
                          ),
                          // style: TextStyle(height: 0),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFFAD8002)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              width: 40,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFFFFC34A)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailController.text);
                                    if (emailController.text == "") {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please insert your email first.",
                                          gravity: ToastGravity.BOTTOM);
                                    } else if (emailValid == false) {
                                      Fluttertoast.showToast(
                                          msg: "Please insert email format.",
                                          gravity: ToastGravity.BOTTOM);
                                    } else if (emailController.text != "" &&
                                        emailValid == true) {
                                      try {
                                        print(emailController.text);
                                        await FirebaseAuth.instance
                                            .sendPasswordResetEmail(
                                                email: emailController.text)
                                            .then(
                                              (value) => Navigator.pop(context),
                                            );
                                      } on FirebaseAuthException catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.message.toString(),
                                            gravity: ToastGravity.BOTTOM);
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
