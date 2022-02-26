import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class tabbar extends StatefulWidget {
  const tabbar({Key? key}) : super(key: key);

  @override
  _tabbarState createState() => _tabbarState();
}

class _tabbarState extends State<tabbar> {
  final List<String> names = <String>[
    'Fix my car',
    'Clean bed room',
    'buy PS5'
  ];
  final List<int> icon = <int>[1, 2, 3];

  TextEditingController nameController = TextEditingController();
  int numicon = 0;

  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
      icon.insert(0, numicon);
    });
  }

  void onDismissed(int index) {
    setState(() {
      names.removeAt(index);
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
          backgroundColor: Colors.white,
          title: Text('Today, I should do'),
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Add what you want to do",
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),

          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.gps_fixed),
                  onPressed: () {
                    numicon = 1;
                    print(numicon);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {
                    numicon = 2;
                    print(numicon);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.access_alarm),
                  onPressed: () {
                    numicon = 3;
                    print(numicon);
                  },
                ),
              ],
            ),
            Row(
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Color(0xFFd0d3d4),
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.amber,
                  child: Text('Add'),
                  onPressed: () {
                    addItemToList();
                    print(nameController.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
            length: 3,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xfffF5EC83),
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Color(0xfffB5B0A2),
                              labelStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              unselectedLabelStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              indicator: BoxDecoration(
                                  color: Color(0xfffFFC34A),
                                  borderRadius: BorderRadius.circular(15)),
                              tabs: [
                                Tab(
                                  text: "Today, I do",
                                ),
                                Tab(
                                  text: "Circle List",
                                ),
                                Tab(
                                  text: "TickTic",
                                )
                              ]),
                        ),
                      ),

                      //tabbarview
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: TabBarView(
                          children: [
                            Container(
                                child: Column(
                              //page1
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      170, 20, 10, 10),
                                  child: Expanded(
                                    flex: 1,
                                    child: Container(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Color(0xfffF9EE6D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Icon(
                                                Icons.info_outline_rounded,
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xfffF9EE6D)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _displayTextInputDialog(
                                                      context);
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Add today's i do",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                Container(
                                  child: (names.isEmpty)
                                      ? Column(children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8)),
                                          Container(
                                            child: Image.asset(
                                                'assets/images/leaf-fall.png'),
                                          ),
                                          Text(
                                            "You don't have any list right now",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.w500),
                                          )
                                        ])
                                      : Expanded(
                                          child: ListView.builder(
                                              padding: const EdgeInsets.all(8),
                                              itemCount: names.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                    height: 80,
                                                    margin: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xfffFFC34A),
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                        child: icon[index] ==
                                                                                1
                                                                            ? Icon(Icons.gps_fixed)
                                                                            : icon[index] == 2
                                                                                ? Icon(Icons.ac_unit)
                                                                                : Icon(Icons.access_alarm)),
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 10)),
                                                                    Text(
                                                                      '${names[index]}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child:
                                                                RoundCheckBox(
                                                              size: 35,
                                                              uncheckedColor:
                                                                  Colors.white,
                                                              checkedColor:
                                                                  Colors.grey,
                                                              onTap:
                                                                  (selected) {
                                                                onDismissed(
                                                                    index);
                                                              },
                                                            ),
                                                          ),
                                                        ]));
                                              }
                                              //          Padding(
                                              //   padding:
                                              //       const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                              //   child: Container(
                                              //       height: 70,
                                              //       decoration: BoxDecoration(
                                              //           borderRadius: BorderRadius.circular(10),
                                              //           color: Color(0xfffFFC34A)),
                                              //       child: Row(
                                              //         children: [
                                              //           Padding(
                                              //             padding: const EdgeInsets.fromLTRB(
                                              //                 20, 10, 10, 10),
                                              //             child: Icon(
                                              //               IconData(0xea8c,
                                              //                   fontFamily: 'MaterialIcons'),
                                              //               color: Colors.red,
                                              //               size: 30.0,
                                              //             ),
                                              //           ),
                                              //           Container(
                                              //             width: 250,
                                              //             child: Text(
                                              //               "ทำการบ้านวิชาSE",
                                              //               style: TextStyle(
                                              //                   fontWeight: FontWeight.normal,
                                              //                   fontSize: 20),
                                              //             ),
                                              //           ),
                                              //           Padding(
                                              //             padding: const EdgeInsets.only(left: 0),
                                              //             child: RoundCheckBox(
                                              //               uncheckedColor: Colors.white,
                                              //               checkedColor: Colors.grey,
                                              //               onTap: (selected) {},
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       )),
                                              // ),
                                              )),

                                  // Padding(
                                  //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  //   child: Container(
                                  //       height: 70,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(10),
                                  //           color: Color(0xfffFFC34A)),
                                  //       child: Row(
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.fromLTRB(
                                  //                 20, 10, 10, 10),
                                  //             child: Icon(
                                  //               IconData(0xea8c,
                                  //                   fontFamily: 'MaterialIcons'),
                                  //               color: Colors.red,
                                  //               size: 30.0,
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             width: 250,
                                  //             child: Text(
                                  //               "ส่งพัสดุ",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.normal,
                                  //                   fontSize: 20),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding:
                                  //                 const EdgeInsets.only(right: 10),
                                  //             child: RoundCheckBox(
                                  //               uncheckedColor: Colors.white,
                                  //               checkedColor: Colors.grey,
                                  //               onTap: (selected) {},
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )),
                                  // ),
                                )
                              ],
                            )),

                            //page2
                            Container(
                                child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(210, 20, 0, 0),
                                  child: Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 40,
                                      child: Row(children: [
                                        Container(
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Color(0xfffF9EE6D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Icon(
                                                  Icons.info_outline_rounded,
                                                  size: 30,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color(0xfffF9EE6D)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10)),
                                                Text(
                                                  "See more",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.zero,
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                      height: 80,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xfffFFC34A)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 10, 5, 5),
                                            child: Image.asset(
                                              "assets/images/Profile.png",
                                              width: 60,
                                              height: 60,
                                            ),
                                          ),
                                          const VerticalDivider(
                                            width: 20,
                                            thickness: 1.5,
                                            indent: 15,
                                            endIndent: 15,
                                            color: Colors.white,
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 230,
                                                child: Text(
                                                  "Martin",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Container(
                                                width: 230,
                                                child: Text(
                                                  "รดน้ำต้นไม้ให้พ่อด้วยฮะมุง",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: RoundCheckBox(
                                              uncheckedColor: Colors.white,
                                              checkedColor: Colors.grey,
                                              onTap: (selected) {},
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            )),

                            //page3
                            Container(
                                margin: EdgeInsets.only(right: 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          265, 20, 00, 0),
                                      child: Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color(0xfffF9EE6D)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10)),
                                                Text(
                                                  "See more",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.zero,
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      margin: const EdgeInsets.all(11),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xFFFFC34A),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 6, 0, 0),
                                                child: Text(
                                                  "Shopping",
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        200, 6, 0, 0),
                                                child: FavoriteButton(
                                                  iconSize: 30,
                                                  iconDisabledColor:
                                                      Colors.white,
                                                  valueChanged: (_isFavorite) {
                                                    print(
                                                        'Is Favorite $_isFavorite)');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: RoundCheckBox(
                                                  size: 22,
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.green,
                                                  onTap: (selected) {},
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7),
                                                child: Text("นมตราหมี"),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))));
  }
}
