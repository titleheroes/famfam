import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterCircleID extends StatefulWidget {
  final Widget child;
  const EnterCircleID({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<EnterCircleID> createState() => _EnterCircleIDState();
}

class _EnterCircleIDState extends State<EnterCircleID> {
  List<UserModel> userModels = [];

  @override
  void initState() {
    super.initState();
    pullUserSQLID();
  }

  Future<Null> pullUserSQLID() async {
    final String getUID = FirebaseAuth.instance.currentUser!.uid.toString();
    String uid = getUID;
    String pullUser =
        '${MyConstant.domain}/famfam/getUserWhereUID.php?isAdd=true&uid=$uid';
    await Dio().get(pullUser).then((value) async {
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          userModels.add(model);
        });
      }
    });
  }

  final User user = FirebaseAuth.instance.currentUser!;
  TextEditingController circleCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: TextField(
            controller: circleCodeController,
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
              hintText: 'Enter invite Circle Code here',
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        //   //padding: EdgeInsets.only(top: ),
        //   margin: EdgeInsets.symmetric(vertical: 28),
        //   width: size.width * 0.8,
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(25),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey,
        //           blurRadius: 5.0,
        //           offset: Offset(0, 3),
        //         ),
        //         BoxShadow(
        //           color: Colors.white,
        //           offset: Offset(-5, 0),
        //         ),
        //         BoxShadow(
        //           color: Colors.white,
        //           offset: Offset(5, 0),
        //         )
        //       ]),
        //   child: child,
        // ),
        SizedBox(height: 300),
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(bottom: ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.1 - 37,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(29),
                      //   // boxShadow: [
                      //   //   BoxShadow(
                      //   //     color: Colors.grey.withOpacity(0.4),
                      //   //     spreadRadius: 1,
                      //   //     offset: Offset(0, 3), // changes position of shadow
                      //   //   ),
                      //   // ],
                      // ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFAD8002)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(fontSize: 21, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    width: 100,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.1 - 37,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(25.0),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.grey.withOpacity(0.4),
                      //       spreadRadius: 1,
                      //       offset:
                      //           Offset(0, 3), // changes position of shadow
                      //     ),
                      //   ],
                      // ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFFFC34A)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          List<CircleModel> circleModels = [];
                          String circle_code = circleCodeController.text;
                          String pullCircleInfo =
                              '${MyConstant.domain}/famfam/getCircleWhereCode.php?isAdd=true&circle_code=$circle_code';
                          await Dio().get(pullCircleInfo).then((value) async {
                            if (value.toString() == 'null') {
                              Fluttertoast.showToast(
                                  msg:
                                      "There is no 'Circle' with this Circle ID",
                                  gravity: ToastGravity.BOTTOM);
                              print("Blank Circle ID");
                            } else {
                              for (var item in json.decode(value.data)) {
                                CircleModel model = CircleModel.fromMap(item);
                                setState(() {
                                  circleModels.add(model);
                                });
                                String? circle_id = circleModels[0].circle_id;
                                String? circle_name =
                                    circleModels[0].circle_name;
                                String? host_id = circleModels[0].host_id;
                                String? member_id = userModels[0].id;
                                String apiInsertCircle =
                                    "${MyConstant.domain}/famfam/insertCirclewithID.php?isAdd=true&circle_id=$circle_id&circle_code=$circle_code&circle_name=$circle_name&host_id=$host_id&member_id=$member_id";
                                await Dio()
                                    .get(apiInsertCircle)
                                    .then((value) async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString(
                                      'circle_id', circle_id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(user),
                                    ),
                                  );
                                });
                              }
                            }
                          });
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 21),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }
}
