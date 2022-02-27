import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/register.dart';
import 'package:famfam/welcome.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/auth.dart';

class Login extends StatelessWidget {
  final AuthService _auth = AuthService();
  Login({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    "Let's sign you in.",
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
                    "Welcome back.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 0, 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "You've been missed",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                //Password
                Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 00),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white.withOpacity(0.8),
                      filled: true,
                    ),
                    // style: TextStyle(height: 0),
                  ),
                ),
                //Forgot password
                TextButton(
                  onPressed: () {},
                  // alignment: Alignment.centerRight,
                  // padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                  // )
                  child: Text('Forgot Password ?',
                      style: TextStyle(color: Colors.grey.shade800)),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(230, 0, 0, 0),
                  ),
                ),

                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text('Login'),
                    onPressed: () async {
                      _auth.signin(context, emailController.text.trim(),
                          passwordController.text.trim());
                    },
                  ),
                ),

                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/register");
                          },
                          // alignment: Alignment.centerRight,
                          // padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                          // )
                          child: Text('Register',
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
    )));
  }
}
