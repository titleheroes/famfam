import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/my_order_model.dart';
import 'package:famfam/screens/components/body.dart';
import 'package:famfam/models/list_today_ido.dart';
import 'package:famfam/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/models/ticktick_model.dart';

class tabbar extends StatefulWidget {
  const tabbar({Key? key}) : super(key: key);

  @override
  _tabbarState createState() => _tabbarState();
}

class List_showModel {
  final String topic;
  final String topic_id;
  final bool fav;
  List_showModel(this.topic, this.topic_id, this.fav);
}

class Product {
  final String product_name;
  final String product_id;
  Product(this.product_name, this.product_id);
}

class _tabbarState extends State<tabbar> {
  final List<String> list_todo = <String>[];
  final List<int> icon = <int>[1, 2, 3];

  TextEditingController nameController = TextEditingController();
  int numicon = 0;
  int num = 0;
  List<UserModel> userModels = [];
  List<list_today_Model> list_to_do_Models = [];

  void addItemToList(String text) {
    setState(() {
      list_todo.insert(0, text);
      icon.insert(0, numicon);
      // nameController.text = '';
      numicon = 0;
    });
  }

  void onDismissed(int index) {
    setState(() {
      print('############list wanna delete ' + list_todo[index]);
      DeleteDatatoday(list_to_do: list_todo[index]);
      list_todo.removeAt(index);
      print('deleted successed');
    });
  }

  @override
  void initState() {
    super.initState();
    pullUserSQLID();
  }

  void addItemfromStart() {
    print(list_to_do_Models.length);
    for (int i = 0; i < list_to_do_Models.length; i++) {
      addItemToList(list_to_do_Models[i].list_to_do);
    }
  }

  Future<Null> pullUserSQLID() async {
    final String getUID = FirebaseAuth.instance.currentUser!.uid.toString();
    String uid = getUID;
    print('#### uid ' + getUID);
    String pullUser =
        '${MyConstant.domain}/famfam/getUserWhereUID.php?uid=$uid&isAdd=true';
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
          print(item);
          setState(() {
            userModels.add(model);
          });
        }
      }
    });
    await pullDataToday_IDO();
    addItemfromStart();
    pullCircle();
    pullMyOrderUnfinished();
  }

  Future<Null> pullDataToday_IDO() async {
    String? member_id = userModels[0].id;
    print('###UID_frompulldata ==> ' + '$member_id');
    String pullData =
        '${MyConstant.domain}/famfam/getDataToday_IDO.php?isAdd=true&user_id=$member_id';
    try {
      await Dio().get(pullData).then((value) async {
        for (var item in json.decode(value.data)) {
          list_today_Model list_model = list_today_Model.fromMap(item);
          print(item);
          setState(() {
            list_to_do_Models.add(list_model);
          });
        }
      });
    } catch (e) {}
  }

  Future<Null> InsertDatatoday({String? list_to_do}) async {
    String? member_id = userModels[0].id;
    print('###UID ==> ' + '$member_id');
    String APIinsertData =
        '${MyConstant.domain}/famfam/insertDataToday_IDO.php?user_id=$member_id &list_to_do=$list_to_do&isAdd=true';
    await Dio().get(APIinsertData).then((value) {
      if (value.toString() == 'true') {
        print('Insert Today I Do Successed');
      }
    });
  }

  Future<Null> DeleteDatatoday({String? list_to_do}) async {
    String? member_id = userModels[0].id;
    String APIDeleteData =
        '${MyConstant.domain}/famfam/deleteDataToday_IDO.php?isAdd=true&user_id=$member_id&list_to_do=$list_to_do';
    await Dio().get(APIDeleteData).then((value) {
      if (value.toString() == 'true') {
        print('Deleted Today I Do Successed');
      }
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
          backgroundColor: Colors.white,
          title: Text('Today, I should do'),
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Add what you want to do",
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),

          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.gps_fixed),
                  onPressed: () {
                    numicon = 1;
                    print(numicon);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {
                    numicon = 2;
                    print(numicon);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.access_alarm),
                  onPressed: () {
                    numicon = 3;
                    print(numicon);
                  },
                ),
              ],
            ),
            Row(
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Color(0xFFd0d3d4),
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.amber,
                  child: Text('Add'),
                  onPressed: () {
                    addItemToList(nameController.text);
                    InsertDatatoday(list_to_do: nameController.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  int count_ticktickUid = 0;
  List<CircleModel> circleModels = [];
  List<ticktick_Model> ticktick_Models = [];
  List<ticktick_Model> tempticktick = [];
  List<List_showModel> list_topic = [];
  List<Product> list_product = [];
  List<MyOrdereModel> unfinishedModels = [];

  Future<Null> pullDataTicktick({String? circle_id, String? member_id}) async {
    count_ticktickUid = 0;
    // print('#### circle_id ' + '${circle_id}');
    // print('#### member_id ' + '${member_id}');
    String pullData =
        '${MyConstant.domain}/famfam/getTickTickWhereCircleIDwithTrue.php?isAdd=true&circle_id=$circle_id&fav_topic=true';
    try {
      await Dio().get(pullData).then((value) async {
        for (var item in json.decode(value.data)) {
          ticktick_Model ticktick_models = ticktick_Model.fromMap(item);
          print(item);
          setState(() {
            ticktick_Models.add(ticktick_models);
            count_ticktickUid = count_ticktickUid + 1;
          });
        }
      });
    } catch (e) {}

    print('count_ticktickuid : ' + '$count_ticktickUid');
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
    await pullDataTicktick(circle_id: circle_id, member_id: member_id);
    try {
      addDatafromstart();
    } catch (e) {}
  }

  Future<Null> pullMyOrderUnfinished() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? circle_id = preferences.getString('circle_id');
    String? employee_id = userModels[0].id;
    String pullMyOrderUnfinished =
        '${MyConstant.domain}/famfam/getMyOrderUnfinished.php?isAdd=true&circle_id=$circle_id&employee_id=$employee_id';
    try {
      await Dio().get(pullMyOrderUnfinished).then((value) async {
        for (var item in json.decode(value.data)) {
          MyOrdereModel model = MyOrdereModel.fromMap(item);
          setState(() {
            unfinishedModels.add(model);
          });
        }
      });
      print(unfinishedModels);
    } catch (e) {}
  }

  Future<Null> addDatafromstart() async {
    int num = 1;
    var arr = [];
    for (int i = 0; i <= count_ticktickUid; i++) {
      if (i == count_ticktickUid - 1) {
        String topic = ticktick_Models[i].tick_topic;
        arr.insert(0, ticktick_Models[i].ticklist_list);
        String? product = ticktick_Models[i].ticklist_list;
        String? product_id = ticktick_Models[i].tick_id;
        bool fav = true;
        // if (ticktick_Models[i].fav_topic == 'true') {
        //   fav = true;
        // } else {
        //   fav = false;
        // }

        String? id = ticktick_Models[i].tick_id;
        // print('id :' + '${id}');
        // print('topic :' + topic);
        // print('list : ' + '$arr');
        // print('num : ' + '$num');

        setState(() {
          list_topic.add(List_showModel(topic, id!, fav));
          list_product.add(Product(product, product_id!));
        });
        // print(list_topic);
        break;
      } else if (ticktick_Models[i].tick_uid ==
          ticktick_Models[i + 1].tick_uid) {
        // print('## i : ' + ticktick_Models[i].tick_uid);
        // print('## i+1 : ' + ticktick_Models[i + 1].tick_uid);
        String? product = ticktick_Models[i].ticklist_list;
        String? product_id = ticktick_Models[i].tick_id;
        arr.insert(0, product);
        setState(() {
          list_product.add(Product(product, product_id!));
        });
        num = num + 1;
      } else {
        String topic = ticktick_Models[i].tick_topic;
        // print(i);
        String? product = ticktick_Models[i].ticklist_list;
        String? product_id = ticktick_Models[i].tick_id;
        arr.insert(0, ticktick_Models[i].ticklist_list);
        String? id = ticktick_Models[i].tick_id;
        bool fav;
        if (ticktick_Models[i].fav_topic == 'true') {
          fav = true;
        } else {
          fav = false;
        }
        // print('id :' + '${id}');
        // print('topic :' + topic);
        // print('list : ' + '$arr');
        // print('num : ' + '$num');
        setState(() {
          list_topic.add(List_showModel(topic, id!, fav));
          list_product.add(Product(product, product_id!));
        });
        arr = [];
        num = 1;
      }
    }
  }

  Future<Null> deletedlistByIDandName(
      {String? product_id, String? product_name}) async {
    String deletedDataList =
        '${MyConstant.domain}/famfam/deleteTickTickList.php?isAdd=true&tick_id=$product_id&ticklist_list=$product_name';
    await Dio().get(deletedDataList).then((value) {
      if (value.toString() == 'true') {
        print('Deleted List By ID Successed');
      }
    });
  }

  void onDismissedTickTick(String product_name, String product_id) {
    int checkEmpty = 0;
    setState(() {
      list_product.removeWhere((item) =>
          item.product_name == '$product_name' &&
          item.product_id == '$product_id');
      deletedlistByIDandName(
          product_id: product_id, product_name: product_name);

      print('deleted list successed');

      for (int i = 0; i < list_product.length; i++) {
        if (list_product[i].product_id == product_id) {
          checkEmpty = checkEmpty + 1;
          print(checkEmpty);
        }
      }
    });
    if (checkEmpty == 0) {
      print(checkEmpty);
      setState(() {
        list_topic.removeWhere((item) => item.topic_id == '$product_id');
        print('deleted topic successed');
      });
    }
  }

  Future<Null> updateFav({String? fav_topic, String? tick_id}) async {
    String updateDataFav =
        '${MyConstant.domain}/famfam/updateFavTickTick.php?isAdd=true&fav_topic=$fav_topic&tick_id=$tick_id';
    await Dio().get(updateDataFav).then((value) {
      if (value.toString() == 'true') {
        print('Updated Fav By ID Successed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xfffF5EC83),
                      ),
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Color(0xfffB5B0A2),
                            labelStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            unselectedLabelStyle:
                                TextStyle(fontWeight: FontWeight.normal),
                            indicator: BoxDecoration(
                                color: Color(0xfffFFC34A),
                                borderRadius: BorderRadius.circular(15)),
                            tabs: [
                              Tab(
                                text: "Today, I do",
                              ),
                              Tab(
                                text: "Circle List",
                              ),
                              Tab(
                                text: "TickTic",
                              )
                            ]),
                      ),
                    ),

                    //tabbarview
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: TabBarView(
                        children: [
                          Container(
                              child: Column(
                            //page1
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(170, 20, 10, 10),
                                child: Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xfffF9EE6D),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Icon(
                                              Icons.info_outline_rounded,
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xfffF9EE6D)),
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
                                                _displayTextInputDialog(
                                                    context);
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Add today's i do",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Container(
                                child: (list_todo.isEmpty)
                                    ? Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8)),
                                          Container(
                                            child: SvgPicture.asset(
                                              "assets/icons/leaf-fall.svg",
                                              height: 85,
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                            ),
                                          ),
                                          Text(
                                            "You don't have any list right now",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: list_todo.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                  height: 80,
                                                  margin: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xfffFFC34A),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                      child: icon[index] ==
                                                                              1
                                                                          ? Icon(
                                                                              Icons.gps_fixed)
                                                                          : icon[index] == 2
                                                                              ? Icon(Icons.ac_unit)
                                                                              : Icon(Icons.access_alarm)),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              10)),
                                                                  Text(
                                                                    '${list_todo[index]}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: RoundCheckBox(
                                                            size: 35,
                                                            uncheckedColor:
                                                                Colors.white,
                                                            checkedColor:
                                                                Colors.grey,
                                                            onTap: (selected) {
                                                              onDismissed(
                                                                  index);
                                                            },
                                                          ),
                                                        ),
                                                      ]));
                                            })),
                              )
                            ],
                          )),

                          //page2
                          Container(
                              child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(210, 20, 0, 0),
                                child: Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 40,
                                    child: Row(children: [
                                      Container(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Color(0xfffF9EE6D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Icon(
                                                Icons.info_outline_rounded,
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xfffF9EE6D)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TodoBody(tabSelected: 0),
                                              ),
                                            ).then((value) => setState(() {}));
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Text(
                                                "See more",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: Icon(
                                                  Icons.navigate_next,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              Container(
                                child: unfinishedModels.isEmpty
                                    ? Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8)),
                                          Container(
                                            child: SvgPicture.asset(
                                              "assets/icons/leaf-fall.svg",
                                              height: 85,
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                            ),
                                          ),
                                          Text(
                                            "You don't have any list right now",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: unfinishedModels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      margin: EdgeInsets.only(
                                                          bottom: 6),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xfffFFC34A),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 10, 10),
                                                        child: Row(
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment
                                                            //         .spaceBetween,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 6,
                                                                        right:
                                                                            2),
                                                                child: Builder(builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        RoundCheckBox(
                                                                            isChecked:
                                                                                false,
                                                                            onTap:
                                                                                null),
                                                                        FlatButton(
                                                                          color:
                                                                              Colors.white,
                                                                          shape: RoundedRectangleBorder(
                                                                              side: BorderSide(
                                                                                color: Colors.transparent,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(50)),
                                                                          onPressed:
                                                                              () async {
                                                                            {
                                                                              // ติ๊กถูก
                                                                              if (userModels[0].id != unfinishedModels[index].employee_id) {
                                                                                Fluttertoast.showToast(msg: "You can't finish other people assignment.", gravity: ToastGravity.BOTTOM);
                                                                              } else {
                                                                                //ทำเสร็จไป UPDATE DATABASE
                                                                                var user = FirebaseAuth.instance.currentUser;
                                                                                String? my_order_id = unfinishedModels[index].my_order_id;
                                                                                String my_order_status = 'true';
                                                                                String apiUpdateStatusMyOrder = '${MyConstant.domain}/famfam/updateStatusMyOrder.php?isAdd=true&my_order_id=$my_order_id&my_order_status=$my_order_status';
                                                                                await Dio().get(apiUpdateStatusMyOrder).then((value) async {
                                                                                  Navigator.pop(context);
                                                                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user)));
                                                                                });
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                              const VerticalDivider(
                                                                width: 20,
                                                                thickness: 1.5,
                                                                indent: 5,
                                                                endIndent: 5,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          3,
                                                                          10,
                                                                          0),
                                                                  child:
                                                                      RaisedButton(
                                                                    color:
                                                                        Color(
                                                                      0xfffFFC34A,
                                                                    ),
                                                                    elevation:
                                                                        0,
                                                                    hoverElevation:
                                                                        0,
                                                                    focusElevation:
                                                                        0,
                                                                    highlightElevation:
                                                                        0,
                                                                    onPressed:
                                                                        () {
                                                                      descDialog(
                                                                          context,
                                                                          unfinishedModels[index]
                                                                              .my_order_topic,
                                                                          unfinishedModels[index]
                                                                              .my_order_desc);
                                                                    },
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CheckMe(
                                                                              index,
                                                                              unfinishedModels),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            '${unfinishedModels[index].my_order_topic}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          5,
                                                                          5,
                                                                          5),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 25,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            unfinishedModels[index].employee_profile),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              //   child: Container(
                              //     height: 80,
                              //     width: 400,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         color: Color(0xfffFFC34A)),
                              //     child: Row(
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.fromLTRB(
                              //               5, 10, 5, 5),
                              //           child: Image.asset(
                              //             "assets/images/Profile.png",
                              //             width: 60,
                              //             height: 60,
                              //           ),
                              //         ),
                              //         const VerticalDivider(
                              //           width: 20,
                              //           thickness: 1.5,
                              //           indent: 15,
                              //           endIndent: 15,
                              //           color: Colors.white,
                              //         ),
                              //         Column(
                              //           children: [
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Container(
                              //               width: 230,
                              //               child: Text(
                              //                 "Martin",
                              //                 style: TextStyle(
                              //                     fontWeight:
                              //                         FontWeight.normal,
                              //                     fontSize: 15),
                              //               ),
                              //             ),
                              //             Container(
                              //               width: 230,
                              //               child: Text(
                              //                 "รดน้ำต้นไม้ให้พ่อด้วยฮะมุง",
                              //                 style: TextStyle(
                              //                     fontWeight:
                              //                         FontWeight.normal,
                              //                     fontSize: 18),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         Padding(
                              //           padding:
                              //               const EdgeInsets.only(left: 0),
                              //           child: RoundCheckBox(
                              //             uncheckedColor: Colors.white,
                              //             checkedColor: Colors.grey,
                              //             onTap: (selected) {},
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          )),

                          //page3
                          Container(
                              margin: EdgeInsets.only(right: 0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        265, 20, 00, 0),
                                    child: Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xfffF9EE6D)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                    context, '/ticktik')
                                                .then((value) {
                                              setState(() {});
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Text(
                                                "See more",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: Icon(
                                                  Icons.navigate_next,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: (list_topic.isEmpty)
                                          ? Column(children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              8)),
                                              Container(
                                                child: SvgPicture.asset(
                                                  "assets/icons/leaf-fall.svg",
                                                  height: 85,
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              Text(
                                                "You don't have any list right now",
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ])
                                          : Expanded(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  itemCount: list_topic.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                        height: 150,
                                                        margin:
                                                            EdgeInsets.all(15),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color(
                                                              0xfffFFC34A),
                                                          // color: Colors.white,
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            15,
                                                                        top:
                                                                            15),
                                                                    child: Text(
                                                                        '${list_topic[index].topic}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                  ),
                                                                  Spacer(),
                                                                  Container(
                                                                    child: IconButton(
                                                                        iconSize: 22,
                                                                        icon: Icon(
                                                                          Icons
                                                                              .favorite,
                                                                        ),
                                                                        color: list_topic[index].fav ? Colors.red : Colors.white,
                                                                        onPressed: () async {
                                                                          // bool
                                                                          //     isChecked =
                                                                          //     false;
                                                                          String
                                                                              fav_topic =
                                                                              'false';
                                                                          String
                                                                              tick_id =
                                                                              list_topic[index].topic_id;
                                                                          String
                                                                              updateDataFav =
                                                                              '${MyConstant.domain}/famfam/updateFavTickTick.php?isAdd=true&fav_topic=$fav_topic&tick_id=$tick_id';
                                                                          await Dio()
                                                                              .get(updateDataFav)
                                                                              .then((value) {
                                                                            // if (value.toString() == 'true') {
                                                                            print('Updated Fav By ID Successed');
                                                                            // }
                                                                            setState(() {
                                                                              list_topic.removeWhere((item) => item.topic_id == '${list_topic[index].topic_id}');
                                                                              print('deleted topic successed');
                                                                            });
                                                                          });
                                                                          // setState(() {});
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                  child: ListView
                                                                      .builder(
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          itemCount: list_product
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index2) {
                                                                            if (list_topic[index].topic_id ==
                                                                                list_product[index2].product_id) {}
                                                                            return Container(
                                                                                child: (list_topic[index].topic_id == list_product[index2].product_id)
                                                                                    ? Wrap(children: <Widget>[
                                                                                        Container(
                                                                                            margin: EdgeInsets.only(left: 15, top: 20),
                                                                                            child: Row(children: [
                                                                                              Container(
                                                                                                child: RoundCheckBox(
                                                                                                  size: 22,
                                                                                                  uncheckedColor: Colors.white,
                                                                                                  checkedColor: Colors.green,
                                                                                                  onTap: (selected) {
                                                                                                    print('selected ' + list_product[index2].product_id);
                                                                                                    print('selected ' + list_product[index2].product_name);

                                                                                                    onDismissedTickTick(list_product[index2].product_name, list_product[index2].product_id);
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(right: 10, left: 10),
                                                                                                child: Text('${list_product[index2].product_name}'),
                                                                                              )
                                                                                            ]))
                                                                                      ])
                                                                                    : SizedBox.shrink());
                                                                          }))
                                                            ]));
                                                  })))

                                  // Container(
                                  //   height: 140,
                                  //   margin: const EdgeInsets.all(11),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     color: Color(0xFFFFC34A),
                                  //   ),
                                  //   child: Column(
                                  //     children: [
                                  //       SizedBox(
                                  //         height: 10,
                                  //       ),
                                  //       Row(
                                  //         children: [
                                  //           Padding(
                                  //             padding:
                                  //                 const EdgeInsets.fromLTRB(
                                  //                     30, 6, 0, 0),
                                  //             child: Text(
                                  //               "Shopping",
                                  //               textAlign: TextAlign.left,
                                  //               style:
                                  //                   TextStyle(fontSize: 22),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding:
                                  //                 const EdgeInsets.fromLTRB(
                                  //                     200, 6, 0, 0),
                                  //             child: FavoriteButton(
                                  //               iconSize: 30,
                                  //               iconDisabledColor:
                                  //                   Colors.white,
                                  //               valueChanged: (_isFavorite) {
                                  //                 print(
                                  //                     'Is Favorite $_isFavorite)');
                                  //               },
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 7,
                                  //       ),
                                  //       Row(
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 30),
                                  //             child: RoundCheckBox(
                                  //               size: 22,
                                  //               uncheckedColor: Colors.white,
                                  //               checkedColor: Colors.green,
                                  //               onTap: (selected) {},
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 left: 7),
                                  //             child: Text("นมตราหมี"),
                                  //           )
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text CheckMe(int index, List<MyOrdereModel> model) {
    if (model[index].owner_id == userModels[0].id &&
        model[index].employee_id == userModels[0].id) {
      return Text(
        "Me to Myself",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      );
    } else if (model[index].owner_id == userModels[0].id &&
        model[index].employee_id != userModels[0].id) {
      return Text(
        "Me to ${model[index].employee_fname}",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      );
    } else {
      return Text(
        "${model[index].owner_fname} to Myself",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      );
    }
  }
}
