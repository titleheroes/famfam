import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:famfam/loading.dart';
import 'package:famfam/login.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:flutter/material.dart';
// import 'package:famfam/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in email, password
  Future signin(BuildContext context, email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
    }
  }

  //register with email, password

  //signout
  void signOut(BuildContext context) async {
    _auth.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        ModalRoute.withName('/')));
  }

  //check auth
  Future checkAuth(BuildContext context) async {
    String serverCheck = '${MyConstant.domain}/famfam/connected.php';
    try {
      await Dio().get(serverCheck);
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print("Already signed-in");

        //check currentUser circle
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? circle_id = preferences.getString('circle_id');

        //Check already have circle?
        if (circle_id?.isEmpty ?? true) {
          //pull user data from mysql
          Future<Null> pullUserSQLID() async {
            var user = FirebaseAuth.instance.currentUser;
            final String getUID =
                FirebaseAuth.instance.currentUser!.uid.toString();
            String uid = getUID;
            String pullUser =
                '${MyConstant.domain}/famfam/getUserWhereUID.php?isAdd=true&uid=$uid';
            try {
              await Dio().get(pullUser).then((value) async {
                //go check have user data on mysql?

                // if no go to Login
                if (value.toString() == null ||
                    value.toString() == 'null' ||
                    value.toString() == '') {
                  user!.delete();
                  FirebaseAuth.instance.signOut();
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear().then(
                        (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          ModalRoute.withName('/'),
                        ),
                      );

                  //else if have go to CreateCircle
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => createCircleScreen(),
                    ),
                  );
                }
              });
            } catch (e) {
              FirebaseAuth.instance.signOut();
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Loading(),
                ),
              );
            }
          }
        } else {
          print('has Circle already');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(user),
            ),
          );
        }
      } else {
        Navigator.pushNamed(context, '/welcome');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Server Error',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 24);
      sleep(Duration(seconds: 5));
      exit(0);
    }
  }
}
