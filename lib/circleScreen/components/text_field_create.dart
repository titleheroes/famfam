import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/circleScreen/createCricle/random_id.dart';
import 'package:famfam/circleScreen/inputCircle/inputCircleScreen.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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

  @override
  Widget build(BuildContext context) {
    TextEditingController circleNameController = TextEditingController();
    final String getUID = FirebaseAuth.instance.currentUser!.uid.toString();
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
              controller: circleNameController,
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
                hintText: 'Ex. Sabaidee Family',
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
          //   child: widget.child,
          // ),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 15.0),
                  child: Divider(
                    color: Color(0xff8B8A85),
                    height: 45,
                    thickness: 2,
                  )),
            ),
            Text(
              "OR",
            ),
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 40.0),
                  child: Divider(
                    color: Color(0xff8B8A85),
                    height: 45,
                    thickness: 2,
                  )),
            ),
          ]),
          Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you have Circle ID ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InputCircleScreen()));
                    },
                    child: Text('Click here!',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        )),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 170),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFFFC34A)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (circleNameController.text != null &&
                                circleNameController.text != '') {
                              print(userModels[0].id);
                              var uuid = Uuid();
                              String circle_code = uuid.v1();
                              String circle_name = circleNameController.text;
                              String? user_id = userModels[0].id;

                              print('$circle_code, $circle_name, $user_id');

                              String apiInsertCircle =
                                  "${MyConstant.domain}/famfam/insertCircle.php?isAdd=true&circle_code=$circle_code&circle_name=$circle_name&user_id=$user_id";

                              await Dio().get(apiInsertCircle).then((value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Random_id(
                                      circle_code: circle_code,
                                    ),
                                  ),
                                );
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please insert Circle Name First",
                                  gravity: ToastGravity.BOTTOM);
                              print("Blank info");
                            }
                          },
                          child: Text(
                            "Create",
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
      ),
    );
  }
}
