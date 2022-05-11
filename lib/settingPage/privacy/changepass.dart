import 'package:famfam/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController OldPassController = TextEditingController();

  TextEditingController NewPassController = TextEditingController();

  TextEditingController RetypePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Change Password",
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
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  "Old Password",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextField(
                  obscureText: true,
                  controller: OldPassController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Type your old password',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  "New Password",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: TextField(
                      obscureText: true,
                      controller: NewPassController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type your new password',
                          hintStyle: TextStyle(color: Colors.grey[500])))),
              Container(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  "Re - type Password",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextField(
                  obscureText: true,
                  controller: RetypePassController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Re-type your password',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFFFC34A),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      var user = FirebaseAuth.instance.currentUser;
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: FirebaseAuth.instance.currentUser!.email!,
                          password: NewPassController.text,
                        );
                        user!.updatePassword(NewPassController.text).then((_) {
                          print("Successfully changed password");
                        }).catchError((error) {
                          print("Password can't be changed" + error.toString());
                          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                      if (OldPassController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please insert old password.",
                            gravity: ToastGravity.BOTTOM);
                      } else if (NewPassController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please insert new password.",
                            gravity: ToastGravity.BOTTOM);
                      } else if (RetypePassController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please retype new password.",
                            gravity: ToastGravity.BOTTOM);
                      } else if (NewPassController.text !=
                          RetypePassController.text) {
                        Fluttertoast.showToast(
                            msg:
                                "Please enter new password as same as retype password.",
                            gravity: ToastGravity.BOTTOM);
                      } else {
                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return CupertinoAlertDialog(
                                title: const Text('Please Confirm'),
                                content: const Text(
                                    'Are you sure to change password ?'),
                                actions: [
                                  // The "Yes" button
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Text('Cancel'),
                                    isDefaultAction: false,
                                    isDestructiveAction: false,
                                  ),
                                  // The "No" button
                                  CupertinoDialogAction(
                                    onPressed: () async {
                                      var user =
                                          FirebaseAuth.instance.currentUser;
                                      user!
                                          .updatePassword(
                                              NewPassController.text)
                                          .then((value) {
                                        print("Successfully changed password");
                                      }).catchError((error) {
                                        print("Password can't be changed" +
                                            error.toString());
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                          msg: "Password can't be changed",
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }).then((value) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                          msg: 'Successfully changed password',
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      });
                                    },
                                    child: const Text('Confirm'),
                                    isDefaultAction: true,
                                    isDestructiveAction: true,
                                  )
                                ],
                              );
                            });
                      }
                    },
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
