import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:famfam/constants.dart';
import 'package:flutter/services.dart';

class CircleBotSheet extends StatelessWidget {
  final Size size;
  const CircleBotSheet({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width * 0.864,
          height: size.height * 0.066,

          //color: Colors.pink,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFF9EE6D)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
              ),
              child: Text(
                '+ Add List ',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(62.0))),
                    backgroundColor: Color(0xFFFFFFFF),
                    context: context,
                    isScrollControlled: true,
                    enableDrag: false,
                    builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
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
                                              'Add List to Circle',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            'Title',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              //color: Color(0xFFFFFFFF),
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.021),
                                          Container(
                                            //margin: EdgeInsets.only(top: 40),
                                            //width: size.width * 0.831,

                                            child: (Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  boxShadow: [
                                                    const BoxShadow(
                                                      color: Colors.black,
                                                    ),
                                                  ]),
                                              child: (TextField(
                                                style: TextStyle(
                                                    fontSize: 20, height: 1.5),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xFFF8F8F8),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                  //border: InputBorder.none,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0),
                                                  ),
                                                  hintText: 'Write the title',
                                                  hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )),
                                            )),
                                          ),
                                          SizedBox(height: size.height * 0.021),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Description",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    /*                 
                                                    SizedBox(
                                                      width: size.width * 0.4,
                                                    ),
                                                    */
                                                    /*

                                                    Text("Points",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),

                                                    */
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.021),
                                                Container(
                                                  // width: size.width * 0.58,
                                                  // height:
                                                  //     size.height * 0.054,
                                                  child: (TextField(
                                                    textAlignVertical:
                                                        TextAlignVertical.top,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        height: 1.5),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xFFF8F8F8),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 20),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFF9EE6D),
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60.0),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFF9EE6D),
                                                            width: 2.0),
                                                      ),
                                                      hintText:
                                                          'Write the description',
                                                      hintStyle: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                                /*
                                                Row(
                                                  children: [
                                                    Container(
                                                      // width: size.width * 0.58,
                                                      // height:
                                                      //     size.height * 0.054,
                                                      child: (TextField(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .top,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            height: 1.5),
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
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
                                                                        15.0),
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFF9EE6D),
                                                                width: 2.0),
                                                          ),
                                                          hintText:
                                                              'Write the description',
                                                          hintStyle: TextStyle(
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      )),
                                                    ),
                                                    /*
                                                    SizedBox(
                                                      width: size.width * 0.055,
                                                    ),
                                                    
                                                    Container(
                                                      width: size.width * 0.15,
                                                      //height: size.height * 0.054,
                                                      child: (TextField(
                                                        maxLength: 2,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .top,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            height: 1.5),
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: '',
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
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
                                                                        15.0),
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
                                                                        15.0),
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFFF9EE6D),
                                                                width: 2.0),
                                                          ),
                                                          hintText: '0',
                                                          hintStyle: TextStyle(
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      )),
                                                    ),
                                                  */
                                                  ],
                                                ),
                                                */

                                                SizedBox(
                                                    height:
                                                        size.height * 0.028),
                                                Text(
                                                  'Who',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    //color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: size.height * 0.01),
                                                Row(
                                                  children: [
                                                    //ต้องทำให้รูปกดได้ด้วย

                                                    // ElevatedButton(
                                                    //   child: Image.asset(
                                                    //       "assets/images/face1.png"),
                                                    //   onPressed: () {},
                                                    // ),

                                                    Image.asset(
                                                        "assets/images/face1.png"),
                                                    Image.asset(
                                                        "assets/images/face2.png"),
                                                    Image.asset(
                                                        "assets/images/face3.png"),
                                                    Image.asset(
                                                        "assets/images/face4.png"),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.028),
                                                Center(
                                                    child: Container(
                                                  width: 208,
                                                  height: 60,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color(
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
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          fontSize: 21,
                                                          color: Colors.black),
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
                        ));
              }),
        )
      ],
    );
  }
}
