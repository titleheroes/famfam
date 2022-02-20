import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/login.dart';
import 'package:flutter/material.dart';
// import 'package:famfam/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in email, password
  Future signin(BuildContext context, email, password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        var user = FirebaseAuth.instance.currentUser;
        print("signed in");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage(user)));
      });
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
    }
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
