<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:firebase_storage/firebase_storage.dart';
=======
import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
>>>>>>> parent of 0cf775f (sqlite helper)
=======
import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
>>>>>>> parent of 0cf775f (sqlite helper)
=======
import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
>>>>>>> parent of 0cf775f (sqlite helper)
=======
import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
>>>>>>> parent of 0cf775f (sqlite helper)
=======
import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
>>>>>>> parent of 0cf775f (sqlite helper)
=======
import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
>>>>>>> parent of 0cf775f (sqlite helper)
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
=======
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> parent of 2bd146a (insert to sqlite)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register_Info extends StatefulWidget {
  const Register_Info(
      {Key? key, String? emailController, String? passwordController})
      : super(key: key);

  @override
  _Register_InfoState createState() => _Register_InfoState();
}

class _Register_InfoState extends State<Register_Info> {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  FirebaseAuth _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime? _dateTime;
=======
  late DateTime _dateTime;
>>>>>>> parent of 0cf775f (sqlite helper)
=======
  late DateTime _dateTime;
>>>>>>> parent of 0cf775f (sqlite helper)
=======
  late DateTime _dateTime;
>>>>>>> parent of 0cf775f (sqlite helper)
=======
  late DateTime _dateTime;
>>>>>>> parent of 0cf775f (sqlite helper)
=======
  late DateTime _dateTime;
>>>>>>> parent of 0cf775f (sqlite helper)
=======
  late DateTime _dateTime;
>>>>>>> parent of 0cf775f (sqlite helper)
  String getText() {
    if (_dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('dd-MM-yyyy').format(_dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EE6D),
      // appBar: AppBar(
      //   title: Text("TorTlew"),
      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -30,
                  left: -65,
                  child: Image.asset("assets/images/block.png"),
                  // child: Text(
                  //   "Hello",
                  //   style: TextStyle(
                  //     fontSize: 32,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ),
                Positioned(
                  top: 100,
                  right: -80,
                  child: Image.asset("assets/images/block2.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 50.0, left: 30.0),
                  child: Text(
                    "\nNow let's get to\nknow each other.\n\n\n\n",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 200.0),
              child: Stack(
                children: [
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
                  Container(
                    margin: const EdgeInsets.only(top: 55.0),
                    width: MediaQuery.of(context).size.width,
                    height: 1140.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E5BA),
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(65),
                        topLeft: Radius.circular(65),
                      ),
                    ),
                  ),

                  //Profile Avatar
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(
                                'https://media.discordapp.net/attachments/797533903832743936/939938331083554906/rambo2__130821152859.png'),
                          ),
                        ),
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
=======
                  Profile_frame(),
                  Profile_avatar(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                  Profile_frame(),
                  Profile_avatar(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                  Profile_frame(),
                  Profile_avatar(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                  Profile_frame(),
                  Profile_avatar(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                  Profile_frame(),
                  Profile_avatar(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                  Profile_frame(),
                  Profile_avatar(),
>>>>>>> parent of 0cf775f (sqlite helper)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 160.0),
                      width: 360,
                      color: Colors.transparent,
                      child: Column(
                        children: [
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
//First Name
=======
                          //First Name
>>>>>>> parent of 2bd146a (insert to sqlite)
=======
                          //First Name
>>>>>>> parent of 2bd146a (insert to sqlite)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: fnameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. Janejira',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Last Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Last Name\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. Sabaidee',
                                  ),
                                ),
                              ),
                            ],
                          ),
=======
                          First_name(),
=======
                          First_name(),

<<<<<<< HEAD
                          Last_name(),
>>>>>>> parent of 0cf775f (sqlite helper)

                          Last_name(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          First_name(),
=======
                          First_name(),

                          Last_name(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          First_name(),

                          Last_name(),
>>>>>>> parent of 0cf775f (sqlite helper)

                          Last_name(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          First_name(),

                          Last_name(),
>>>>>>> parent of 0cf775f (sqlite helper)

                          Phone_number(),

=======
                          Phone_number(),

>>>>>>> parent of 2bd146a (insert to sqlite)
                          // Birthdate
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Birthdate\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  child: Text(getText()
                                      // _dateTime == null
                                      //       ? "Pick a Date"
                                      //       : formatter.format(_dateTime)
                                      //   _dateTime.toString()
                                      ),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () => pickDate(context),
                                ),
                              ),
                            ],
                          ),

                          Address(),

                          Personal_ID(),

                          Jobs(),

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
// Finish Button
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 1,
                                            offset: Offset(0,
                                                3), // changes position of shadow
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
                                        onPressed: () async {
                                          user!.delete();
                                          await _auth.signOut();
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => Login(),
                                          //   ),
                                          // );
                                          Navigator.popAndPushNamed(
                                              context, '/login');
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
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 1,
                                            offset: Offset(0,
                                                3), // changes position of shadow
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
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      createCircleScreen()));
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
                              )
                            ],
                          ),
=======
                          Finish_Button(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          Finish_Button(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          Finish_Button(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          Finish_Button(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          Finish_Button(),
>>>>>>> parent of 0cf775f (sqlite helper)
=======
                          Finish_Button(),
>>>>>>> parent of 0cf775f (sqlite helper)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1940),
        lastDate: DateTime.now());

    if (newDate == null) return;

    setState(() => _dateTime = newDate);
  }
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
class Finish_Button extends StatelessWidget {
  const Finish_Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
        ),
        Row(
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFAD8002)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFFFC34A)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => createCircleScreen()));
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
        )
      ],
    );
  }
}

class Profile_avatar extends StatelessWidget {
  const Profile_avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.black,
            ),
          ),
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Text(
                  "+",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Profile_frame extends StatelessWidget {
  const Profile_frame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 55.0),
      width: MediaQuery.of(context).size.width,
      height: 1140.0,
      decoration: BoxDecoration(
        color: Color(0xFFF1E5BA),
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(65),
          topLeft: Radius.circular(65),
        ),
      ),
    );
  }
}

class Jobs extends StatelessWidget {
  const Jobs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Jobs\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. Student',
            ),
          ),
        ),
      ],
    );
  }
}

class Personal_ID extends StatelessWidget {
  const Personal_ID({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Personal ID\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. 1100432567895',
            ),
          ),
        ),
      ],
    );
  }
}

class Address extends StatelessWidget {
  const Address({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Address\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
            maxLines: 3,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. 77/108 Tashkent Uzbekistan\n      10112',
            ),
          ),
        ),
      ],
    );
  }
}

class Phone_number extends StatelessWidget {
  const Phone_number({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Phone number\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. 0812345678',
            ),
          ),
        ),
      ],
    );
  }
}

class Last_name extends StatelessWidget {
  const Last_name({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Last Name\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. Sabaidee',
            ),
          ),
        ),
      ],
    );
  }
}

class First_name extends StatelessWidget {
  const First_name({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "First Name\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
<<<<<<< HEAD
<<<<<<< HEAD
=======
            // controller: fnameController,
>>>>>>> parent of 2bd146a (insert to sqlite)
=======
            // controller: fnameController,
>>>>>>> parent of 2bd146a (insert to sqlite)
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. Janejira',
            ),
          ),
        ),
      ],
    );
  }
}

<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of 0cf775f (sqlite helper)
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
=======
>>>>>>> parent of 2bd146a (insert to sqlite)
DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
