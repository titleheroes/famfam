import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/widgets/circle_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/models/pinpost_model.dart';
import 'package:famfam/models/replynumber.dart';
// import 'package:famfam/widgets/slide_dots.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:famfam/pinpost_screen/reply_pin_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _BodyState();
}

class _BodyState extends State<PinScreen> {
  bool load = true;
  bool? haveData;
  List<UserModel> userModels = [];
  List<PinpostModel> pinpostModels = [];
  List<ReplyNumberModel> replynumberModels = [];

  List<String> names = <String>[
    'Dummy Pin Post Right Here!',
    'zzzzzzzz',
    'ssssss'
  ];
  TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pullUserSQLID().then((value) {
      getPinpostFromCircle().then((value) => getReplyNumberFromCircleID());
    });
  }

  void addItemToList() {
    setState(() {
      names.insert(0, pinController.text);
    });
  }

  void onDismissed(int index) {
    setState(() {
      names.removeAt(index);
    });
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

  Future getPinpostFromCircle() async {
    if (pinpostModels.length != 0) {
      pinpostModels.clear();
    } else {}

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String circle_id = preferences.getString('circle_id')!;
    String author_id = userModels[0].id!;

    print('## circle_id = $circle_id');
    String path =
        '${MyConstant.domain}/famfam/getPinWhereCircleID.php?isAdd=true&circleID_pinpost=$circle_id';

    await Dio().get(path).then((value) {
      //print(value);

      if (value.toString() == 'null') {
        //No Data
        setState(() {
          //load = false;
          haveData = false;
        });
      } else {
        //Have Data
        for (var item in json.decode(value.data)) {
          PinpostModel model = PinpostModel.fromMap(item);
          print('Pintext ==>> ${model.pin_text} by ${model.fname}');

          setState(() {
            //load = false;
            haveData = true;
            pinpostModels.add(model);
          });
        }
      }
    });
  }

  void SendPinText(String input_pin_text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String circle_id = preferences.getString('circle_id')!;
    String author_id = userModels[0].id!;
    String author_fname = userModels[0].fname;
    String pin_text = input_pin_text;

    print('## text = $pin_text');

    String InsertPinpost =
        '${MyConstant.domain}/famfam/insertPin.php?isAdd=true&pin_text=$pin_text&author_id=$author_id&circle_id=$circle_id';

    await Dio().get(InsertPinpost).then((value) {
      if (value.toString() == 'true') {
        print('Pinpost Inserted');
      } else {
        print('Insert Error');
      }
    });
    getReplyNumberFromCircleID();
    getPinpostFromCircle();
    //Navigator.pushNamed(context, '/pinpost');
  }

  Future<void> _displayEditDialog(
      BuildContext context, String pin_id, String pin_text) async {
    TextEditingController pinEditController = TextEditingController();
    pinEditController.text = "${pin_text}";

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Edit Pin Post'),
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextFormField(
                //initialValue: "${pin_text}",
                controller: pinEditController,
                decoration: InputDecoration(
                  hintText: "${pin_text}",
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),
          actions: <Widget>[
            Center(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 2,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(150, 40),
                          backgroundColor: Color.fromARGB(255, 139, 139, 139),
                          alignment: Alignment.center,
                        ),
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(150, 40),
                        backgroundColor: Color.fromARGB(255, 224, 222, 72),
                        alignment: Alignment.center,
                      ),
                      child:
                          Text('Edit', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        print('Edited text = ' + pinEditController.text);
                        String EditPinpost =
                            '${MyConstant.domain}/famfam/editPinfromPinID.php?isAdd=true&pin_id=$pin_id&pin_text=${pinEditController.text}';
                        await Dio().get(EditPinpost).then((value) {
                          if (value.toString() == 'true') {
                            print('Pinpost Edited');
                          } else {
                            print('Edit Error');
                          }
                        });
                        getPinpostFromCircle();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _displayDeleteDialog(BuildContext context, String pin_id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Are you sure you want to delete this Pin Post?'),
          actions: <Widget>[
            Center(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(150, 40),
                          backgroundColor: Color.fromARGB(255, 139, 139, 139),
                          alignment: Alignment.center,
                        ),
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(150, 40),
                        backgroundColor: Color.fromARGB(255, 248, 102, 102),
                        alignment: Alignment.center,
                      ),
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        DeletePinpost(pin_id);
                        //onDismissed();

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void DeletePinpost(String pin_id) async {
    String target_pin_id = pin_id;
    String DeletePinpost =
        '${MyConstant.domain}/famfam/deletePinFromPinID.php?isAdd=true&pin_id=$target_pin_id';

    print('## target = $target_pin_id');

    await Dio().get(DeletePinpost).then((value) {
      if (value.toString() == 'True') {
        print('Pinpost Deleted');
      } else {
        print('Delete Error');
      }
    });
    //Navigator.pushNamed(context, '/pinpost');
    getPinpostFromCircle();
  }

  Future getReplyNumberFromCircleID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String circle_id = preferences.getString('circle_id')!;

    if (replynumberModels.length != 0) {
      replynumberModels.clear();
    } else {}

    String path =
        '${MyConstant.domain}/famfam/getReplyNumberWhereCircleID.php?isAdd=true&circle_id=$circle_id';

    await Dio().get(path).then((getvalue) {
      //print(value);

      if (getvalue.toString() == 'null') {
        //No Data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        //Have Data
        for (var item in json.decode(getvalue.data)) {
          ReplyNumberModel model = ReplyNumberModel.fromMap(item);
          print(
              'Pin_ID ==>> ${model.pin_id} have ${model.number_of_reply} reply');

          setState(() {
            load = false;
            haveData = true;
            replynumberModels.add(model);
          });
        }
      }
    });
  }

  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;

    TextEditingController pinController = TextEditingController();

    void addItemToList() {
      setState(() {
        names.insert(0, pinController.text);
        print(names);
      });
    }

    Size size = MediaQuery.of(context).size;

    return new WillPopScope(
      onWillPop: () {
        if (load == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(user)),
          );
        } else {
          null;
        }

        return Future.value(false);
      },
      child: Scaffold(
          //Main Screen
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBar(
              leading: Transform.translate(
                offset: Offset(0, 12),
                child: load
                    ? null
                    : IconButton(
                        icon: Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(user)));
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
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          body: load
              ? CircleLoader()
              : SafeArea(
                  child: Container(
                    //color: Colors.pink,
                    width: double.infinity,

                    padding: EdgeInsets.only(
                        top: 10, left: 24, right: 24, bottom: 0),
                    child: Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 50,
                                //color: Colors.cyan,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding: const EdgeInsets.all(8),
                                    itemCount: pinpostModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DateTime tempDate =
                                          new DateFormat("yyyy-MM-dd hh:mm")
                                              .parse(pinpostModels[index].date);
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy - kk:mm')
                                              .format(tempDate);
                                      //print(tempDate);

                                      return Stack(
                                        children: [
                                          Container(
                                            width: size.width,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal: 24,
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: index ==
                                                        pinpostModels.length - 1
                                                    ? 100
                                                    : 20),
                                            decoration: BoxDecoration(
                                              color: Color(0xfffF5EC83),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    pinpostModels[
                                                                            index]
                                                                        .profileImage),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 10,
                                                          ),
                                                          child: Text(
                                                            '${pinpostModels[index].fname}',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      formattedDate,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: Text(
                                                        '${pinpostModels[index].pin_text}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            height: 1.5),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${pinpostModels[index].number_of_reply} Replied',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      height:
                                                                          1.5,
                                                                      color: Colors
                                                                          .black),
                                                                  recognizer:
                                                                      TapGestureRecognizer()
                                                                        ..onTap =
                                                                            () {
                                                                          print('Tapped ==>> ' +
                                                                              pinpostModels[index].pin_id);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => ReplyPinScreen(
                                                                                  pinpostModels[index].pin_id,
                                                                                ),
                                                                              ));
                                                                        }),
                                                            ])),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (userModels[0].id ==
                                              pinpostModels[index].author_id)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      _displayEditDialog(
                                                          context,
                                                          pinpostModels[index]
                                                              .pin_id,
                                                          pinpostModels[index]
                                                              .pin_text);
                                                    },
                                                    icon: Icon(Icons.edit),
                                                    iconSize: 30,
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _displayDeleteDialog(
                                                          context,
                                                          pinpostModels[index]
                                                              .pin_id);
                                                    },
                                                    icon: Icon(Icons.close),
                                                    iconSize: 30,
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      );
                                    }),
                              )),

                              //SizedBox(height: 50,),
                            ],
                          ),
                          Positioned(
                              bottom: 20,
                              right: 5,
                              child: //bottomsheet
                                  Stack(
                                children: [
                                  Container(
                                    //width: size.width * 0.8,
                                    width: size.width * 0.3,
                                    height: size.height * 0.08,

                                    //color: Colors.cyan,

                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(
                                                      255, 243, 230, 90)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Add Pin!',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            62.0))),
                                            backgroundColor: Colors.white,
                                            context: context,
                                            isScrollControlled: true,
                                            enableDrag: false,
                                            builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 25.0),
                                                      child: Container(
                                                        height:
                                                            size.height * 0.595,
                                                        child: Container(
                                                          width:
                                                              size.width * 0.84,
                                                          decoration:
                                                              BoxDecoration(
                                                                  //color: hexToColor("#F1E5BA"),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    66),
                                                            topRight:
                                                                Radius.circular(
                                                                    66),
                                                          )),
                                                          child: Column(
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment.center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                  height: 45),
                                                              Center(
                                                                child: Text(
                                                                  'Add Pin Post',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 30),
                                                              Text(
                                                                'What\'s on your mind',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              SizedBox(
                                                                  height: size
                                                                          .height *
                                                                      0.021),
                                                              Container(
                                                                //margin: EdgeInsets.only(top: 40),
                                                                //width: size.width * 0.831,

                                                                child:
                                                                    (Container(
                                                                  decoration:
                                                                      BoxDecoration(
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
                                                                  child:
                                                                      (TextField(
                                                                    controller:
                                                                        pinController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    maxLines: 8,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        height:
                                                                            1.5),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10,
                                                                          horizontal:
                                                                              20),
                                                                      //border: InputBorder.none,
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(18.0),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Color(0xFFF9EE6D),
                                                                            width: 2.0),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(18.0),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Color(0xFFF9EE6D),
                                                                            width: 2.0),
                                                                      ),
                                                                      hintText:
                                                                          'Write your Pin Post',
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                  )),
                                                                )),
                                                              ),
                                                              SizedBox(
                                                                  height: size
                                                                          .height *
                                                                      0.021),
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
                                                                        child:
                                                                            Container(
                                                                      width:
                                                                          208,
                                                                      height:
                                                                          60,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all<Color>(Color(0xFFF9EE6D)),
                                                                          shape:
                                                                              MaterialStateProperty.all(
                                                                            RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(90.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          /*----------------- Here ---------------------------------*/
                                                                          print('Input: ' +
                                                                              pinController.text);
                                                                          //print('Current circle_id: ' + circle_id );
                                                                          //getPinpostFromCircle(pinController.text);
                                                                          SendPinText(
                                                                              pinController.text);
                                                                          //addItemToList();
                                                                          /*----------------- Here ---------------------------------*/

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
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
                                                        bottom: MediaQuery.of(
                                                                context)
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
                              ))
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
