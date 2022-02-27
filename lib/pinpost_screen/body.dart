import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/pinpost_screen/components/pinbottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/Homepage/menuHome.dart';
import 'dart:math';
import 'package:famfam/Homepage/date.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double value = 0;

  @override
  void initState() {
    //uid = user.uid;
    super.initState();
  }

  Widget build(BuildContext context) {
    //final List<String> author = <String>['Me', 'Me'];
    final User user = FirebaseAuth.instance.currentUser!;
    final List<String> names = <String>['Something Big', 'Something Smol'];
    TextEditingController nameController = TextEditingController();
    void addItemToList() {
      setState(() {
        names.insert(1, nameController.text);
      });
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //Main Screen
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          leading: Transform.translate(
            offset: Offset(0, 12),
            child: IconButton(
              icon: Icon(
                Icons.navigate_before_rounded,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage(user)));
              },
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Transform.translate(
            offset: Offset(0, 12),
            child: Text(
              "Pin Post",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
          child: SingleChildScrollView(
            child: Container(
                child: Column(
              children: [
                // Container(
                //   //color: Colors.blue,
                //   height: size.height * 0.09,
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
                //         child: Text(
                //           "Pin Post",
                //           style: TextStyle(
                //               fontSize: 33,
                //               fontWeight: FontWeight.w800),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    child: Container(
                  //width: size.width * 0.85,
                  height: size.height * 0.7,
                  //color: Colors.red,
                  child: (SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
/*
                                      Expanded(
                                          child: ListView.builder(
                                          
                                              itemCount: names.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Container(
                                                  height: size.height * 0.2,
                                                  width: size.width * 0.85,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 1,
                                                          blurRadius: 10,
                                                          offset: Offset(4, 8),
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Color(0xFFF9F6C6)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15,
                                                                    15,
                                                                    0,
                                                                    0),
                                                            child: (Image.asset(
                                                              "assets/images/J-Profile.png",
                                                              width: 40,
                                                              height: 40,
                                                            )),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    10,
                                                                    0,
                                                                    0),
                                                            child: (Text(
                                                              "Me",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20),
                                                            )),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    130,
                                                                    13,
                                                                    0,
                                                                    0),
                                                            child: (Text(
                                                              formattedDate,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5)),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            20, 0, 0, 0),
                                                        width: size.width * 0.6,
                                                        //color: Colors.red,
                                                        child: Text(
                                                          '${names[index]}',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                              
                                              
                                              )  
                                              )

*/

                          /*  One Card */

                          Container(
                            height: size.height * 0.2,
                            width: size.width * 0.85,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFF9F6C6)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 15, 0, 0),
                                      child: (Image.asset(
                                        "assets/images/J-Profile.png",
                                        width: 40,
                                        height: 40,
                                      )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 0),
                                      child: (Text(
                                        "Me",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          130, 13, 0, 0),
                                      child: (Text(
                                        formattedDate,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      )),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  width: size.width * 0.6,
                                  //color: Colors.red,
                                  child: Text(
                                    'dataaaaaaaaa                           1.เอเอเอเอเอเอเอเอเอ                          2.บีบีบีบีบีบีบีบีบีบีบบีบีบี                       3.ซีซีซีซีซีซีซีซีซีซีซีซีซีซี      ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /*  One Card */

                          /*
                                SizedBox(height: 20,),

                                Container(
                                  height: size.height * 0.15,
                                  width: size.width *0.85,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1,blurRadius: 10,offset: Offset(4,8), ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFF9F6C6)), 
                                ),

                                */
                        ],
                      ))),
                )),
                SizedBox(
                  height: 20,
                ),

                //bottomsheet
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.864,
                      height: size.height * 0.066,

                      //color: Colors.pink,

                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF9EE6D)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Pin your Post!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(62.0))),
                              backgroundColor: Colors.white,
                              context: context,
                              isScrollControlled: true,
                              enableDrag: false,
                              builder: (context) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Container(
                                          height: size.height * 0.595,
                                          child: Container(
                                            width: size.width * 0.84,
                                            decoration: BoxDecoration(
                                                //color: hexToColor("#F1E5BA"),
                                                borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(66),
                                              topRight: Radius.circular(66),
                                            )),
                                            child: Column(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 45),
                                                Center(
                                                  child: Text(
                                                    'Add Pin Post',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(height: 30),
                                                Text(
                                                  'What\'s on your mind',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.021),
                                                Container(
                                                  //margin: EdgeInsets.only(top: 40),
                                                  //width: size.width * 0.831,

                                                  child: (Container(
                                                    decoration: BoxDecoration(
                                                      //color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      // boxShadow: [
                                                      //   const BoxShadow(
                                                      //     color: Colors.black,
                                                      //   ),
                                                      // ]
                                                    ),
                                                    //height: 300,
                                                    child: (TextField(
                                                      controller:
                                                          nameController,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: 8,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          height: 1.5),
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        20),
                                                        //border: InputBorder.none,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFF9EE6D),
                                                              width: 2.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFF9EE6D),
                                                              width: 2.0),
                                                        ),
                                                        hintText:
                                                            'Write your Pin Post',
                                                        hintStyle: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                    )),
                                                  )),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.021),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //SizedBox(height: size.height * 0.021),

                                                      SizedBox(
                                                          height: size.height *
                                                              0.007),
                                                      Center(
                                                          child: Container(
                                                        width: 208,
                                                        height: 60,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Color(
                                                                            0xFFF9EE6D)),
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            90.0),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            print('Input: ' +
                                                                nameController
                                                                    .text);
                                                            print(names);
                                                            addItemToList();
                                                            //Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            "Confirm",
                                                            style: TextStyle(
                                                                fontSize: 21,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
                //bottomsheet
              ],
            )),
          ),
        ),
      ),
    );
  }
}
