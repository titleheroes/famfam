import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/tabbar.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFF9EE6D),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      child: Text(
                        DateFormat('EEEE').format(date),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      child: Text(DateFormat('d').format(date),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  Container(
                    child: Text(
                      DateFormat('MMMM, yyyy').format(date),
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          //end date
          //line
          const VerticalDivider(
            width: 20,
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
            color: Color(0xfff707070),
          ),
          //end line

          //แจ้งเตือน
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Father's birthday",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              IconData(
                                0xe3ab,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(
                              'home  ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            Icon(
                              IconData(
                                0xe738,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(
                              '17.00-20.00',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Father's birthday",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              IconData(
                                0xe3ab,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(
                              'home  ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            Icon(
                              IconData(
                                0xe738,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(
                              '17.00-20.00',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          //จบกล่องวันที่
          //ไอคอน ! สีแดงขวาบนคอนเทนเนอร์แรก
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          //   child: CircleAvatar(
          //     child: Icon(
          //       IconData(
          //         0xf00c1,
          //         fontFamily: 'MaterialIcons',
          //       ),
          //       color: Colors.white,
          //       size: 30.0,
          //     ),
          //   ),
          // ),

          //call tabbar
          // Padding(
          //   padding: const EdgeInsets.only(top: 0),
          //   child: tabbar(),
          // ),
          //จบแจ้งเตือน
        ],
      ),
    );
    //จบกล่องวันที่
  }
}
