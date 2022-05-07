import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/Homepage/tabbar.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/history_my_order_model.dart';
import 'package:famfam/models/history_pinpost_model.dart';
import 'package:famfam/models/my_order_model.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/screens/components/body.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  List<UserModel> userModels = [];
  List<CircleModel> circleModels = [];
  List<HistoryMyOrderModel> historyMyOrderModels = [];
  List<HistoryPinPostModel> historyPinPostModels = [];

  @override
  void initState() {
    super.initState();
    pullUserSQLID().then((value) {
      pullCircle().then((value) {
        pullHistoryMyOrder().then((value) {
          historyMyOrderModels.reversed;
        });
        pullHistoryPinPost().then((value) {
          historyPinPostModels.reversed;
        });
      });
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

  Future<Null> pullCircle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');
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

  Future<Null> pullHistoryMyOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');
    String? user_id = userModels[0].id;

    String pullHistoryMyOrderr =
        '${MyConstant.domain}/famfam/getHistoryMyOrderRelation.php?isAdd=true&circle_id=$circle_id&user_id=$user_id';
    try {
      await Dio().get(pullHistoryMyOrderr).then((value) async {
        for (var item in json.decode(value.data)) {
          HistoryMyOrderModel model = HistoryMyOrderModel.fromMap(item);
          setState(() {
            historyMyOrderModels.add(model);
          });
        }
      });
    } catch (e) {}
  }

  Future<Null> pullHistoryPinPost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');

    String pullHistoryPinPost =
        '${MyConstant.domain}/famfam/getHistoryPinPostRelation.php?isAdd=true&circle_id=$circle_id';
    try {
      await Dio().get(pullHistoryPinPost).then((value) async {
        for (var item in json.decode(value.data)) {
          HistoryPinPostModel model = HistoryPinPostModel.fromMap(item);
          setState(() {
            historyPinPostModels.add(model);
          });
        }
      });
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Stack(
            children: [
              Text(""),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(55.0),
                  child: AppBar(
                    title: Text(
                      'History',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(FirebaseAuth.instance.currentUser),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/chevron-back-outline.svg",
                        height: 35,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/information-_1_.svg",
                          height: 30,
                        ),
                        onPressed: () {
                          infoDialog(
                              context,
                              'History ?',
                              'List of your circle history\nWhat they do recently.',
                              0.2);
                        },
                      ),
                    ],
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 29, right: 29),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF9EE6D).withOpacity(0.44),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            height: 66,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  color: Color(0xFFFFC34A),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                unselectedLabelStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                                labelColor: Colors.black87,
                                unselectedLabelColor: Color(0xFFA5A59D),
                                tabs: [
                                  Tab(text: 'My Order'),
                                  Tab(text: 'Pin Post'),
                                  // Tab(text: 'V and R'),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 640,
                              child: TabBarView(
                                children: [
                                  Container(
                                    child: historyMyOrderModels.isEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Container(
                                              //height: 100,
                                              //width: 100,
                                              decoration: BoxDecoration(
                                                  //color: Colors.pink.shade700,
                                                  //borderRadius: BorderRadius.circular(30),
                                                  ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    "assets/icons/leaf-fall.svg",
                                                    height: 85,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),
                                                  Text(
                                                    "You don't have any list right now.",
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: ListView.builder(
                                                  reverse: true,
                                                  shrinkWrap: true,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  itemCount:
                                                      historyMyOrderModels
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minHeight:
                                                                      80),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15,
                                                                    15,
                                                                    15,
                                                                    15),
                                                            child: Builder(
                                                                builder:
                                                                    (context) {
                                                              print(historyMyOrderModels[
                                                                      index]
                                                                  .my_order_status);
                                                              if (historyMyOrderModels[
                                                                          index]
                                                                      .my_order_status ==
                                                                  'false') {
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          '${historyMyOrderModels[index].owner_fname}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ' has Assigned ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "' ${historyMyOrderModels[index].my_order_topic} '",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ' to you.',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'You has finished Assigned ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "' ${historyMyOrderModels[index].my_order_topic} '",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'from',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ' ${historyMyOrderModels[index].owner_fname}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                            }),
                                                          ),
                                                        ),
                                                        Divider(),
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ),
                                  ),
                                  Container(
                                    child: historyPinPostModels.isEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Container(
                                              //height: 100,
                                              //width: 100,
                                              decoration: BoxDecoration(
                                                  //color: Colors.pink.shade700,
                                                  //borderRadius: BorderRadius.circular(30),
                                                  ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    "assets/icons/leaf-fall.svg",
                                                    height: 85,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),
                                                  Text(
                                                    "You don't have any list right now.",
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: ListView.builder(
                                                  reverse: true,
                                                  shrinkWrap: true,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  itemCount:
                                                      historyPinPostModels
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minHeight:
                                                                      55),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15,
                                                                    15,
                                                                    15,
                                                                    15),
                                                            child: Builder(
                                                                builder:
                                                                    (context) {
                                                              if (historyPinPostModels[
                                                                          index]
                                                                      .history_isreply ==
                                                                  '') {
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          '${historyPinPostModels[index].author_name}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ' has posting the PinPost ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          historyPinPostModels[index]
                                                                              .history_isreply,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ' has replied to ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "${historyPinPostModels[index].author_name}'s",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          " PinPost",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                            }),
                                                          ),
                                                        ),
                                                        Divider(),
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future infoDialog(
          BuildContext context, String title, String desc, double size) =>
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Center(
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffF5EC83),
                    ),
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * size,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                              MediaQuery.of(context).size.height * (size - 0.1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
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
                                top: 15, left: 15, right: 15, bottom: 15),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Center(
                                child: Text(
                                  desc,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.066,
                              width: MediaQuery.of(context).size.width * 0.864,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          });
}
