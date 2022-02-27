import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:famfam/Calendar/calendar.dart';

class EditEvens extends StatefulWidget {
  const EditEvens({Key? key}) : super(key: key);

  @override
  _EditEvensState createState() => _EditEvensState();
}

class _EditEvensState extends State<EditEvens> {
  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? time1 = const TimeOfDay(hour: 12, minute: 12);
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: ListView(
      children: [
        Stack(
          children: [
            Container(
              color: Color(0xfffFFC34A),
              child: Column(
                children: [
                  Container(
                    color: Color(0xfffF6E5C7),
                    height: size.height * 0.17,
                    width: size.width * 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 320, top: 20),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 220),
                          child: Text(
                            "Add Note",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 35,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Container(
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                      color: Color(0xfffF6E5C7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 50),
                              child: Text(
                                "26    November",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 50),
                          child: Row(
                            children: [
                              Text(
                                "Hour",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Minute",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Text(
                                  "Hour",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Minute",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 0, 30, 0),
                                child: Container(
                                  height: size.height * 0.1 - 37,
                                  width: size.width * 0.02,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      TimeOfDay? newTime = await showTimePicker(
                                        context: context,
                                        initialTime: time!,
                                      );
                                      if (newTime != null) {
                                        setState(() {
                                          time = newTime;
                                        });
                                      }
                                    },
                                    child: Text(
                                      '${time!.hour.toString()}:${time!.minute.toString()}',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 15, 40, 15),
                                child: Container(
                                  height: size.height * 0.1 - 37,
                                  width: size.width * 0.02,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      TimeOfDay? newTime1 =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: time1!,
                                      );
                                      if (newTime1 != null) {
                                        setState(() {
                                          time1 = newTime1;
                                        });
                                      }
                                    },
                                    child: Text(
                                      '${time1!.hour.toString()}:${time1!.minute.toString()}',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                "Title",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  width: 320,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      fillColor: Colors.white,
                                      hintText: 'Write a title',
                                    ),
                                    autofocus: false,
                                    obscureText: true,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  width: 320,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      fillColor: Colors.white,
                                      hintText: 'Write your assign location',
                                    ),
                                    autofocus: false,
                                    obscureText: true,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                "Note",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  width: 320,
                                  child: TextField(
                                    // controller: _eventController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      fillColor: Colors.white,
                                      hintText: 'Write your important note',
                                    ),
                                    autofocus: false,
                                    obscureText: true,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.73,
                          decoration: BoxDecoration(
                              color: Color(0xfffE7C581),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  "Repeating? ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Container(
                                color: Colors.blue,
                                width: 100,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: size.height * 0.1 - 37,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFFFC34A)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Calendar()));
                                    },
                                    child: Text(
                                      "Add",
                                      style: TextStyle(fontSize: 21),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
