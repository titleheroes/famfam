import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/circleScreen/createCricle/random_id.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateAndJoinCircle extends StatefulWidget {
  @override
  State<CreateAndJoinCircle> createState() => _CreateAndJoinCircleState();
}

class _CreateAndJoinCircleState extends State<CreateAndJoinCircle> {
  bool _expanded = false;

  List<UserModel> userModels = [];

  TextEditingController CreateCircleController = TextEditingController();
  TextEditingController JoinCircleController = TextEditingController();

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
      if (value.toString() == null ||
          value.toString() == 'null' ||
          value.toString() == '') {
        FirebaseAuth.instance.signOut();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);
          setState(() {
            userModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ExpansionPanelList(
        elevation: 0,
        animationDuration: Duration(milliseconds: 500),
        children: [
          ExpansionPanel(
            backgroundColor: Colors.grey[200],
            headerBuilder: (context, isExpanded) {
              return ListTile(
                  title: Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Create or Join Circle here',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ));
            },
            body: ListTile(
              title: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('Create Circle',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 25, right: 25),
                          child: TextField(
                              controller: CreateCircleController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: 'Type your Circle name',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[500])))),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFFC34A), elevation: 0),
                            child: Text(
                              'Create Circle',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            onPressed: () async {
                              if (CreateCircleController.text != null &&
                                  CreateCircleController.text != '') {
                                print(userModels[0].id);
                                var uuid = Uuid();
                                String circle_code = uuid.v1();
                                String circle_name =
                                    CreateCircleController.text;
                                String? user_id = userModels[0].id;

                                print('$circle_code, $circle_name, $user_id');

                                String apiInsertCircle =
                                    "${MyConstant.domain}/famfam/insertCircle.php?isAdd=true&circle_code=$circle_code&circle_name=$circle_name&user_id=$user_id";

                                await Dio().get(apiInsertCircle).then((value) {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SettingCreateCircle(
                                  //       circle_code: circle_code,
                                  //     ),
                                  //   ),
                                  // );
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.all(20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Stack(
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          circle_name,
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          49, 204, 204, 204),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft: const Radius
                                                            .circular(20.0),
                                                        topRight: const Radius
                                                            .circular(20.0),
                                                        bottomLeft: const Radius
                                                            .circular(20.0),
                                                        bottomRight:
                                                            const Radius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15,
                                                              left: 15,
                                                              right: 15,
                                                              bottom: 15),
                                                      child: Center(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            circle_code,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 35,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    hexToColor(
                                                                        '#FFA500')),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Clipboard.setData(
                                                            ClipboardData(
                                                          text: circle_code,
                                                        ));
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Copied to clipboard.",
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM);
                                                      },
                                                      child: Text(
                                                        'Copy to Clipboard',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: hexToColor(
                                                                '#000000')),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).whenComplete(() async {
                                    List<CircleModel> circleModels = [];
                                    String pullCircle =
                                        '${MyConstant.domain}/famfam/getCircleWhereCode.php?isAdd=true&circle_code=$circle_code';
                                    await Dio()
                                        .get(pullCircle)
                                        .then((value) async {
                                      for (var item
                                          in json.decode(value.data)) {
                                        CircleModel model =
                                            CircleModel.fromMap(item);
                                        setState(() {
                                          circleModels.add(model);
                                        });
                                      }
                                    }).then((value) async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => memberPage(
                                            circle_id:
                                                circleModels[0].circle_id,
                                          ),
                                        ),
                                      );
                                    });
                                  });
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please insert Circle Name First",
                                    gravity: ToastGravity.BOTTOM);
                                print("Blank info");
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Divider(
                          height: 20,
                          thickness: 3,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('Join Circle'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 25, right: 25),
                          child: TextField(
                              controller: JoinCircleController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Type your Circle code',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[500])))),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFFC34A),
                                // padding:
                                //     EdgeInsets.fromLTRB(20, 20, 0, 10),
                                elevation: 0),
                            child: Text(
                              'Join Circle',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              List<CircleModel> circleModels = [];
                              String circle_code = JoinCircleController.text;
                              String pullCircleInfo =
                                  '${MyConstant.domain}/famfam/getCircleWhereCode.php?isAdd=true&circle_code=$circle_code';
                              await Dio()
                                  .get(pullCircleInfo)
                                  .then((value) async {
                                if (value.toString() == 'null') {
                                  Fluttertoast.showToast(
                                      msg:
                                          "There is no 'Circle' with this Circle ID",
                                      gravity: ToastGravity.BOTTOM);
                                  print("Blank Circle ID");
                                } else {
                                  for (var item in json.decode(value.data)) {
                                    CircleModel model =
                                        CircleModel.fromMap(item);
                                    setState(() {
                                      circleModels.add(model);
                                    });
                                    String? circle_id =
                                        circleModels[0].circle_id;
                                    String? circle_name =
                                        circleModels[0].circle_name;
                                    String? host_id = circleModels[0].host_id;
                                    String? member_id = userModels[0].id;
                                    String apiInsertCircle =
                                        "${MyConstant.domain}/famfam/insertCirclewithID.php?isAdd=true&circle_id=$circle_id&circle_code=$circle_code&circle_name=$circle_name&host_id=$host_id&member_id=$member_id";
                                    await Dio()
                                        .get(apiInsertCircle)
                                        .then((value) async {
                                      Navigator.pop(context);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => memberPage(
                                            circle_id:
                                                circleModels[0].circle_id,
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          ),
        ],
        // dividerColor: Colors.grey,
        expansionCallback: (panelIndex, isExpanded) {
          _expanded = !_expanded;
          setState(() {});
        },
      ),
    );
  }
}

class SettingCreateCircle extends StatefulWidget {
  final String circle_code;
  SettingCreateCircle({required this.circle_code});
  @override
  State<SettingCreateCircle> createState() => _SettingCreateCircleState();
}

class _SettingCreateCircleState extends State<SettingCreateCircle> {
  List<CircleModel> circleModels = [];

  @override
  void initState() {
    super.initState();
    pullCircle();
  }

  Future<Null> pullCircle() async {
    String circle_code = widget.circle_code.toString();
    String pullCircle =
        '${MyConstant.domain}/famfam/getCircleWhereCode.php?isAdd=true&circle_code=$circle_code';
    await Dio().get(pullCircle).then((value) async {
      for (var item in json.decode(value.data)) {
        CircleModel model = CircleModel.fromMap(item);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('circle_id', model.circle_id!);
        setState(() {
          circleModels.add(model);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFFF9EE6D),
              child: Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      height: size.height * 1,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(65),
                            topRight: Radius.circular(65),
                          )),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 34, top: 55),
                            child: Text(
                              'It\'s your circle ID!',
                              style: TextStyle(
                                fontSize: 29,
                                //fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 34),
                            child: Text(
                              '\nI\'m glad you created it successfully. Please remember the Circle ID or you just tap on Circle ID and it will copy for you.',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  height: size.height * 0.12 - 37,
                                  width: size.width * 0.75,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              hexToColor('#FFFFFF')),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                        text: widget.circle_code,
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Copied to clipboard')));
                                    },
                                    child: Text(
                                      widget.circle_code,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: hexToColor('#000000')),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 270),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 36),
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
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          hexToColor(
                                                              '#FFC34A')),
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
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage(user),
                                                      ),
                                                      (Route<dynamic> route) =>
                                                          false);
                                                },
                                                child: Text(
                                                  "Next",
                                                  style:
                                                      TextStyle(fontSize: 21),
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
                          ),
                        ],
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
