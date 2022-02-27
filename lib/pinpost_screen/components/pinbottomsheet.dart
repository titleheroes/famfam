import 'package:flutter/material.dart';
import 'package:famfam/pinpost_screen/body.dart';
import 'package:famfam/Homepage/menuHome.dart';
import 'package:intl/intl.dart';

class PinBotSheet extends StatelessWidget {
  final Size size;
  const PinBotSheet({
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
                'Pin your Post!',
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
                    backgroundColor: Colors.white,
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
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            'What\'s on your mind',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: size.height * 0.021),
                                          Container(
                                            //margin: EdgeInsets.only(top: 40),
                                            //width: size.width * 0.831,

                                            child: (Container(
                                              decoration: BoxDecoration(
                                                  //color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  // boxShadow: [
                                                  //   const BoxShadow(
                                                  //     color: Colors.black,
                                                  //   ),
                                                  // ]
                                                  ),
                                              //height: 300,    
                                              child: (TextField(
                                                keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: 8,
                                                style: TextStyle(
                                                    fontSize: 20, height: 1.5),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                  //border: InputBorder.none,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0),
                                                  ),
                                                  hintText: 'Write your Pin Post',
                                                  hintStyle: TextStyle(
                                                    fontSize: 20.0,
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
                                                
                                                //SizedBox(height: size.height * 0.021),


                                                


                                                SizedBox(height: size.height * 0.007),
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
                                                    onPressed: () {
                                                      print('Yes');
                                                      
                                                    },
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
