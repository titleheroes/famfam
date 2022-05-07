import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/profile/Profile.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/service_locator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Member {
  int owner;
  String name;
  String profile;
  Member(this.owner, this.name, this.profile);
}

class memberPage extends StatefulWidget {
  final String? circle_id;
  const memberPage({Key? key, this.circle_id}) : super(key: key);

  @override
  State<memberPage> createState() => _memberPageState();
}

class _memberPageState extends State<memberPage> {
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  List<UserModel> employeeModels = [];
  List<bool> hostChecked = [];
  bool isHost = false;
  bool _isShown = true;

  String familyname = 'Loading...';

  String code = 'loading...';

  @override
  void initState() {
    print(widget.circle_id);
    super.initState();
    pullUserSQLID().then(
      (value) => pullCircle().then((value) {
        familyname = circleModels[0].circle_name;
        code = circleModels[0].circle_code;
      }).then(
        (value) {
          pullEmployeeData().then((value) {
            checkingHost();
          });
        },
      ),
    );
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

  Future<Null> pullCircle() async {
    String? circle_id = widget.circle_id;
    String? member_id = userModels[0].id;
    String pullCircle =
        '${MyConstant.domain}/famfam/getCircleWhereCircleIDuserID.php?isAdd=true&circle_id=$circle_id&member_id=$member_id';
    await Dio().get(pullCircle).then((value) async {
      for (var item in json.decode(value.data)) {
        CircleModel model = CircleModel.fromMap(item);
        setState(() {
          circleModels.add(model);
        });
      }
    });
  }

  Future<Null> pullEmployeeData() async {
    String? circle_id = widget.circle_id;
    String pullEmployee =
        '${MyConstant.domain}/famfam/getUserWhereCircleID.php?isAdd=true&circle_id=$circle_id';
    await Dio().get(pullEmployee).then((value) async {
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          employeeModels.add(model);
        });
      }
    });
  }

  checkingHost() {
    for (int i = 0; i <= employeeModels.length; i++) {
      if (userModels[0].id == circleModels[0].host_id) {
        isHost = true;
      }
      if (employeeModels[i].id == circleModels[0].host_id) {
        hostChecked.add(true);
      } else {
        hostChecked.add(false);
      }
    }
  }

  void _deleteUser(BuildContext context, String circle_id, String member_id) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to kick this user from circle?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Cancel'),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () async {
                  String deleteUser =
                      '${MyConstant.domain}/famfam/deleteUserFromCircleWhereUserID.php?isAdd=true&circle_id=$circle_id&member_id=$member_id';

                  await Dio().get(deleteUser).then((value) async {
                    Navigator.pop(context);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => memberPage(
                          circle_id: circle_id,
                        ),
                      ),
                    );
                  });
                },
                child: const Text('Confirm'),
                isDefaultAction: true,
                isDestructiveAction: true,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
              centerTitle: true,
              title: Text(
                familyname,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => settingPage(),
                    ),
                  );
                },
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                Builder(builder: (context) {
                  if (isHost == true) {
                    return Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {
                              editCircle(
                                context,
                                widget.circle_id!,
                                circleModels[0].circle_name,
                              );
                            },
                            icon: SvgPicture.asset("assets/icons/pencil.svg"),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                })
              ]),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
                padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Text(
                      'Search',
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 300,
                child: ListView.builder(
                  itemCount: employeeModels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return hostChecked[index] == true
                        ? Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                // locator<NavigationService>()
                                //     .navigateTo('members_in_circle_Member');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                      userID: employeeModels[index].uid,
                                      circle_id: circleModels[0].circle_id,
                                      profileUser: 0,
                                      profileMem: 0,
                                      profileOwner: 1,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFF7575),
                                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          employeeModels[index].profileImage),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          ),
                                          Text(
                                            'Owner',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        employeeModels[index].fname,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                // locator<NavigationService>()
                                //     .navigateTo('members_in_circle_Member');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(
                                      userID: employeeModels[index].uid,
                                      circle_id: circleModels[0].circle_id,
                                      profileUser: 0,
                                      profileMem: 1,
                                      profileOwner: 0,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF80E28D),
                                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          employeeModels[index].profileImage),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.assignment_ind,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          ),
                                          Text(
                                            'Member',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        employeeModels[index].fname,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Builder(builder: (context) {
                                    if (isHost == true) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 235, 113, 104),
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 235, 113, 104),
                                                    backgroundImage: AssetImage(
                                                        'assets/images/trash.png'),
                                                  ),
                                                ),
                                                FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  onPressed: () {
                                                    {
                                                      // ติ๊กถูก
                                                      print(
                                                          'click on delete ticktik ${employeeModels[index].id}');
                                                      _isShown == true
                                                          ? _deleteUser(
                                                              context,
                                                              widget.circle_id!,
                                                              employeeModels[
                                                                      index]
                                                                  .id!)
                                                          : null;
                                                    }
                                                  },
                                                  child: Container(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  })
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                      text: code,
                    ));
                    Fluttertoast.showToast(
                        msg: "Copied to clipboard.",
                        gravity: ToastGravity.BOTTOM);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Invite Code : ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          code,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future editCircle(BuildContext context, String id, String title) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        TextEditingController circleNameController = TextEditingController();
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.33,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            'Circle Edit',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: -6,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 30,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Circle Name :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(49, 204, 204, 204),
                      border: Border.all(
                        color: Color(0xFFF9EE6D),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                        bottomLeft: const Radius.circular(20.0),
                        bottomRight: const Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child:
                            // Text(
                            //   'hello',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                            TextField(
                          decoration: new InputDecoration.collapsed(
                              hintText: "Ex. Sabaidee Family"),
                          controller: circleNameController,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: FlatButton(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return CupertinoAlertDialog(
                                  title: const Text('Please Confirm'),
                                  content: const Text(
                                      'Are you sure to delete this circle ?'),
                                  actions: [
                                    // The "Yes" button
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: const Text('Cancel'),
                                      isDefaultAction: false,
                                      isDestructiveAction: false,
                                    ),
                                    // The "No" button
                                    CupertinoDialogAction(
                                      onPressed: () async {
                                        String? circle_id = id;
                                        String deleteCircle =
                                            '${MyConstant.domain}/famfam/deleteCircleWhereCircleID.php?isAdd=true&circle_id=$circle_id';

                                        await Dio()
                                            .get(deleteCircle)
                                            .then((value) async {
                                          Navigator.pop(context);
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                  FirebaseAuth
                                                      .instance.currentUser),
                                            ),
                                          );
                                        });
                                      },
                                      child: const Text('Delete'),
                                      isDefaultAction: true,
                                      isDestructiveAction: true,
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Delete this Circle',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.864,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFF9EE6D),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        if (circleNameController.text == '') {
                          Fluttertoast.showToast(
                              msg: "Please insert Circle's Name first.",
                              gravity: ToastGravity.BOTTOM);
                        } else {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return CupertinoAlertDialog(
                                title: const Text('Please Confirm'),
                                content: const Text(
                                    'Are you sure to edit this change ?'),
                                actions: [
                                  // The "Yes" button
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Text('Cancel'),
                                    isDefaultAction: false,
                                    isDestructiveAction: false,
                                  ),
                                  // The "No" button
                                  CupertinoDialogAction(
                                    onPressed: () async {
                                      String? circle_id = id;
                                      String? circle_name =
                                          circleNameController.text;
                                      String editCircleName =
                                          '${MyConstant.domain}/famfam/editCircleNamefromCircleID.php?isAdd=true&circle_id=$circle_id&circle_name=$circle_name';

                                      await Dio()
                                          .get(editCircleName)
                                          .then((value) async {
                                        Navigator.pop(context);
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => memberPage(
                                              circle_id: id,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: const Text('Confirm'),
                                    isDefaultAction: true,
                                    isDestructiveAction: true,
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
