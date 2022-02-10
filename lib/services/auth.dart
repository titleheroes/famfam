import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/login.dart';
import 'package:flutter/material.dart';
// import 'package:famfam/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in email, password
  Future signin(BuildContext context, email, password) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print("signed in");
      checkAuth(context);
    }).catchError((error) {
      print(error);
    });
  }

  //register with email, password

  //signout
  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        ModalRoute.withName('/'));
  }

  //check auth
  Future checkAuth(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Already signed-in");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(user)));
    } else {
      Navigator.pushNamed(context, '/welcome');
    }
  }
}
