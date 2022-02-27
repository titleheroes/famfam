import 'package:famfam/register_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/menuHome.dart';
import 'dart:math';

class Ezmode extends StatefulWidget {
  @override
  State<Ezmode> createState() => _EzmodeState();
}

class _EzmodeState extends State<Ezmode> {
  double value = 0;
  String family = "Family Name";
  String name = "Janejira";
  int count = 0;

  List<String> profile = <String>[
    'J-Profile.png',
    'J-Profile.png',
    'J-Profile.png',
  ];

  List<String> names = <String>[
    'Janejira',
    'Martin',
    'Mia',
  ];
  List<String> status = <String>['Checked in', 'Checked in', 'Checked in'];
  List<String> address = <String>[
    "KMUTT",
    "The Mall Bangkae",
    "Soi Bean Factory"
  ];
  List<String> time = <String>['10:45', '10:30', '08:57'];

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(color: backgroundColor),
      ),
      SafeArea(child: menuHome()),
      TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: Duration(milliseconds: 500),
          builder: (___, double val, __) {
            return (Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, -280 * val)
                  ..rotateY(-(pi / 6) * val),
                child: MaterialApp(
                    // theme: new ThemeData(
                    //     scaffoldBackgroundColor: const Color(0xFFF6E5C7)),
                    home: Scaffold(
                        //Main Screean

                        body: SafeArea(
                            child: Container(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Container(
                                // decoration: BoxDecoration(color: Color(0xFFF6E5C7)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 20, 0, 0),
                                          child: Text(
                                            family,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    15, 0, 0, 0),
                                                child: Text(
                                                  "Hey, ",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  name + "!",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 60),
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.menu_open_rounded,
                                                  size: 40,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    value == 0
                                                        ? value = 1
                                                        : value = 0;
                                                  });
                                                })),
                                        Container(
                                          padding: EdgeInsets.only(left: 60),
                                          child: Image.asset(
                                              'assets/images/ezmode-logo.png'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 35),
                                      padding: EdgeInsets.all(20),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.23,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              spreadRadius: 3),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Text("Activities",
                                              style: TextStyle(fontSize: 20)),
                                          Expanded(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  itemCount: names.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      height: 50,
                                                      margin:
                                                          EdgeInsets.all(20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Image.asset(
                                                                'assets/images/${profile[index]}'),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .gps_fixed,
                                                                    size: 20,
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              10)),
                                                                  Text(
                                                                      '${names[index]} ' +
                                                                          'is ' +
                                                                          '${status[index]}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18)),
                                                                ],
                                                              ),
                                                              Text(
                                                                  '${address[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18)),
                                                            ],
                                                          ),
                                                          Container(
                                                            child: Text(
                                                                '${time[index]}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      )),
                                ],
                              ))
                            ]),
                          ),
                        )),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.endFloat,
                        floatingActionButton: Container(
                            padding: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FittedBox(
                              child: FloatingActionButton.extended(
                                onPressed: () {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => Theme(
                                            data: Theme.of(context).copyWith(
                                                dialogBackgroundColor:
                                                    Color(0xFFFF4A74)),
                                            child: AlertDialog(
                                              title: Center(
                                                  child: Column(children: [
                                                Container(
                                                    child: Image.asset(
                                                        'assets/images/Alarm.png')),
                                                Text('SOS',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 45)),
                                              ])),
                                              actions: <Widget>[
                                                Container(
                                                    width: double.maxFinite,
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                        onLongPress: () {
                                                          print('long');
                                                          for (var x = 0;
                                                              x < 10000;
                                                              x++) {
                                                            print(x);
                                                            // Navigator.pop(
                                                            //     context, 'ok');
                                                          }
                                                          Navigator.pop(
                                                              context, 'ok');
                                                          showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                              dialogBackgroundColor: Colors.white),
                                                                      child: AlertDialog(
                                                                          title: Center(
                                                                        child: Row(
                                                                            children: [
                                                                              Text('SEND SOS SUCCESSED')
                                                                            ]),
                                                                      ))));
                                                        },
                                                        onLongPressUp: () {
                                                          print('release');
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  right: 30,
                                                                  bottom: 20),
                                                          child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 100,
                                                              child: TextButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .white),
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'ok'),
                                                                child:
                                                                    const Text(
                                                                  'HOLD THIS BUTTON',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              )),
                                                        )))
                                              ],
                                            ),
                                          ));
                                },
                                label: Text(
                                  "SOS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                                icon: Image.asset('assets/images/Alarm.png'),
                                backgroundColor: Color(0xFFFF4A74),
                              ),
                            ))))));
          }),

      //open drawer
      GestureDetector(
        onHorizontalDragUpdate: (e) {
          if (e.delta.dx < 0) {
            setState(() {
              value = 1;
            });
          } else {
            setState(() {
              value = 0;
            });
          }
        },
      )
    ]));
  }
}
