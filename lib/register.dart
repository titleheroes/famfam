import 'package:famfam/login.dart';
import 'package:famfam/register_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                  )),
              Container(
                height: (MediaQuery.of(context).size.height) / 1.74,
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
                        "Welcome!",
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
                        "Enjoy and having fun with our",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 0, 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "application :D",
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
                          labelText: 'Please enter your e-mail',
                          prefixIcon: Icon(Icons.email),
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                        ),
                      ),
                    ),
                    //Password
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 00),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '6-10 characters or number',
                          prefixIcon: Icon(Icons.lock),
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: TextField(
                        obscureText: true,
                        controller: passwordConfirmController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock),
                          fillColor: Colors.white.withOpacity(0.8),
                          filled: true,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text('Register'),
                        onPressed: () async {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                          // print(emailController.text);
                          // print(passwordController.text);
                          // print(passwordConfirmController.text);
                          if (passwordConfirmController.text ==
                                  passwordController.text &&
                              emailValid == true &&
                              emailController.text != "" &&
                              passwordController.text != "" &&
                              passwordConfirmController.text != "") {
                            print("Password Matching!");
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Register_Info(
                            //       emailController: emailController.text,
                            //       passwordController: passwordController.text,
                            //     ),
                            //   ),
                            // );
                            await _auth
                                .createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim())
                                .then((user) {
                              print("Sign up user successful.");
                              Navigator.pushNamed(context, '/registerinfo');
                            }).catchError((error) {
                              print(error.message);
                            });
                          } else if (emailValid == false) {
                            Fluttertoast.showToast(
                                msg: "This is not email format.",
                                gravity: ToastGravity.BOTTOM);
                            print("email not found");
                          } else if (emailController.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please insert the email.",
                                gravity: ToastGravity.BOTTOM);
                            print("email not found");
                          } else if (passwordController.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please insert the password.",
                                gravity: ToastGravity.BOTTOM);
                          } else if (passwordConfirmController.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please insert the confirm-password.",
                                gravity: ToastGravity.BOTTOM);
                          } else if (passwordConfirmController.text !=
                              passwordController.text) {
                            Fluttertoast.showToast(
                                msg: "Password Not Matching!",
                                gravity: ToastGravity.BOTTOM);
                            print("Password Not Matching!");
                          }
                        },
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "if you already had account ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              // alignment: Alignment.centerRight,
                              // padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                              // )
                              child: Text('Log in',
                                  style: TextStyle(
                                    color: Colors.orange.shade900,
                                    fontWeight: FontWeight.w800,
                                  )),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),

          //
          //     child: Column(
          //       children: [
          //
          //         ),
          //
          //

          //
          //       ],
          //     ),
          //   ),

          //  ]
        ),
      ),
    );
  }
}
