// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, use_key_in_widget_constructors

import 'dart:convert';

import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/ticktick_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/components/text_field_container.dart';
import 'package:famfam/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/components/circlebottomsheet.dart';
import 'package:famfam/components/tickbottomsheet.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'header_circle.dart';
import 'package:famfam/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/models/circle_model.dart';

class Body extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderCircle(size: size),
          Container(
            width: size.width * 1,
            height: size.height * 0.74,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(65),
                topRight: Radius.circular(65),
              ),
            ),
            child: Stack(children: <Widget>[
              Container(
                height: size.height * 0.74,
                margin: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(66),
                      topRight: Radius.circular(66),
                    )),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 34, top: 55),
                      child: Text(
                        'Let\'s input Circle ID here!',
                        style: TextStyle(
                          fontSize: 29,
                          //fontFamily: 'Merriweather',
                          fontWeight: FontWeight.bold,
                          //letterSpacing: 1.0
                          //height: 1.8
                        ),
                      ),
                    ),
                    //SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 34),
                      child: Text(
                        '\nEnter the Circle ID that you copied in here. \nThen come and have fun together.',
                        style: TextStyle(
                          fontSize: 19,
                          //fontFamily: 'Merriweather',
                          fontWeight: FontWeight.normal,
                          //letterSpacing: 1.0
                          height: 1.3,
                        ),
                      ),
                    ),
                    RoundedInputField(
                      hintText: 'Enter your Circle ID',
                      onChanged: (String value) {},
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class TodoBody extends StatefulWidget {
  const TodoBody({Key? key}) : super(key: key);

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  final List<String> addLtoC = <String>[];
  final List<String> addDesc = <String>[];
  final List<String> who = <String>[
    'new-arunee.png',
    'new-burin.png',
    'new-mia.png',
    'new-martin_ccexpress.png'
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  int numwho = 0;
  int iconimage = 0;

  void addItemToList() {
    setState(() {
      addLtoC.insert(0, titleController.text);
      addDesc.insert(0, descController.text);
      titleController.text = '';
      descController.text = '';
    });
  }

  void onDismissed(int index) {
    setState(() {
      addLtoC.removeAt(index);
      addDesc.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
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
                    'All Circle \'s list',
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
                    onPressed: () {
                      Navigator.pop(context);
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
                      onPressed: () {},
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
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.shade400,
                                //     blurRadius: 5.0,
                                //     offset: Offset(0, 3),
                                //   ),
                                // ],
                              ),
                              labelStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                              labelColor: Colors.black87,
                              unselectedLabelColor: Color(0xFFA5A59D),
                              tabs: [
                                Tab(text: 'Unfinished'),
                                Tab(text: 'Finished'),
                                Tab(text: 'My order'),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: 640,
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Container(
                                    //height: 100,
                                    //width: 100,
                                    decoration: BoxDecoration(
                                        //color: Colors.pink.shade200,
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
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "You don't have any list right now.",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Container(
                                    //height: 100,
                                    //width: 100,
                                    decoration: BoxDecoration(
                                        //color: Colors.pink,
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
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "You don't have any list right now.",
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: (addLtoC.isEmpty)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
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
                                          child: ListView.builder(
                                              padding: const EdgeInsets.all(8),
                                              itemCount: addLtoC.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: 80,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 6),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Color(
                                                                0xfffFFC34A),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    10,
                                                                    10,
                                                                    10),
                                                            child: Row(
                                                                // mainAxisAlignment:
                                                                //     MainAxisAlignment
                                                                //         .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 6,
                                                                        right:
                                                                            2),
                                                                    child:
                                                                        RoundCheckBox(
                                                                      // size:
                                                                      //     40,
                                                                      uncheckedColor:
                                                                          Colors
                                                                              .white,
                                                                      checkedColor:
                                                                          Colors
                                                                              .grey,
                                                                      onTap:
                                                                          (selected) {
                                                                        onDismissed(
                                                                            index);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const VerticalDivider(
                                                                    width: 20,
                                                                    thickness:
                                                                        1.5,
                                                                    indent: 5,
                                                                    endIndent:
                                                                        5,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  RaisedButton(
                                                                    color:
                                                                        Color(
                                                                      0xfffFFC34A,
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                0),
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
                                                                          addLtoC[
                                                                              index],
                                                                          addDesc[
                                                                              index]);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        // SizedBox(
                                                                        //   height:
                                                                        //       10,
                                                                        // ),
                                                                        Text(
                                                                          "Me to Martin",
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${addLtoC[index]}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                        // Text(
                                                                        //   '${addDesc[index]}',
                                                                        //   style: TextStyle(
                                                                        //       fontSize:
                                                                        //           18),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            5,
                                                                            5,
                                                                            5),
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/${who[index]}",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                        addMyOrder(size, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack addMyOrder(Size size, BuildContext context) {
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
                                                controller: titleController,
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
                                                      controller:
                                                          descController,
                                                      textAlignVertical:
                                                          TextAlignVertical.top,
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
                                                            Color(0xFFF8F8F8),
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
                                                                      60.0),
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
                                                                      60.0),
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
                                                  SizedBox(
                                                      height:
                                                          size.height * 0.028),
                                                  Text(
                                                    'Who',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //color: Color(0xFFFFFFFF),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          size.height * 0.01),
                                                  Row(
                                                    children: [
                                                      Wrap(
                                                        direction:
                                                            Axis.horizontal,
                                                        children: List.generate(
                                                            who.length,
                                                            (index) {
                                                          return Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  // padding:
                                                                  //     EdgeInsets
                                                                  //         .only(
                                                                  //   top: 10,
                                                                  //   bottom: 10,
                                                                  // ),
                                                                  onTap: () {
                                                                    iconimage =
                                                                        numwho;
                                                                    print(
                                                                        numwho);
                                                                    numwho =
                                                                        numwho +
                                                                            1;
                                                                  },
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/${who[index]}',
                                                                    width: 55,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 11,
                                                  ),
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
                                                          print(numwho);
                                                          addItemToList();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Confirm",
                                                          style: TextStyle(
                                                              fontSize: 21,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                          )
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

class TickBody extends StatefulWidget {
  const TickBody({Key? key}) : super(key: key);

  @override
  State<TickBody> createState() => _TickBodyState();
}

List<UserModel> userModels = [];
List<CircleModel> circleModels = [];
List<ticktick_Model> ticktick_Models = [];
List<ticktick_Model> tempticktick = [];
int count_ticktickUid = 0;

class List_showModel {
  final String topic;
  final String topic_id;

  List_showModel(this.topic, this.topic_id);
}

class Product {
  final String product_name;
  final String product_id;
  Product(this.product_name, this.product_id);
}

class _TickBodyState extends State<TickBody> {
  List<List_showModel> listshow = [];
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    pullUserSQLID().then((value) => pullCircle().then((value) {}));
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
    addDatafromstart();
  }

  Future<Null> pullDataTicktick({String? circle_id, String? member_id}) async {
    count_ticktickUid = 0;
    // print('#### circle_id ' + '${circle_id}');
    // print('#### member_id ' + '${member_id}');
    String pullData =
        '${MyConstant.domain}/famfam/getTickTickWhereCircleID.php?isAdd=true&circle_id=$circle_id';
    await Dio().get(pullData).then((value) async {
      for (var item in json.decode(value.data)) {
        ticktick_Model ticktick_models = ticktick_Model.fromMap(item);
        print(item);
        setState(() {
          count_ticktickUid = count_ticktickUid + 1;
          ticktick_Models.add(ticktick_models);
        });
      }
    });
    print('count_ticktickuid : ' + '$count_ticktickUid');
  }

  List<List_showModel> list_topic = [];
  List<Product> list_product = [];

  Future<Null> addDatafromstart() async {
    int num = 1;
    var arr = [];
    for (int i = 0; i <= count_ticktickUid; i++) {
      if (ticktick_Models[i].tick_uid == ticktick_Models[i + 1].tick_uid) {
        print('## i : ' + ticktick_Models[i].tick_uid);
        print('## i+1 : ' + ticktick_Models[i + 1].tick_uid);
        String? product = ticktick_Models[i].ticklist_list;
        String? product_id = ticktick_Models[i].tick_id;
        arr.insert(0, product);
        setState(() {
          list_product.add(Product(product, product_id!));
        });
        num = num + 1;
      } else if (i == count_ticktickUid - 1) {
        String topic = ticktick_Models[i].tick_topic;
        arr.insert(0, ticktick_Models[i].ticklist_list);
        String? product = ticktick_Models[i].ticklist_list;
        String? product_id = ticktick_Models[i].tick_id;
        print(i);
        String? id = ticktick_Models[i].tick_id;
        print('id :' + '${id}');
        print('topic :' + topic);
        print('list : ' + '$arr');
        print('num : ' + '$num');

        setState(() {
          list_topic.add(List_showModel(topic, id!));
          list_product.add(Product(product, product_id!));
        });
        // print(list_topic);
        break;
      } else {
        String topic = ticktick_Models[i].tick_topic;
        // print(i);
        String? product = ticktick_Models[i].ticklist_list;
        String? product_id = ticktick_Models[i].tick_id;
        arr.insert(0, ticktick_Models[i].ticklist_list);
        String? id = ticktick_Models[i].tick_id;
        print('id :' + '${id}');
        print('topic :' + topic);
        print('list : ' + '$arr');
        print('num : ' + '$num');
        setState(() {
          list_topic.add(List_showModel(topic, id!));
          list_product.add(Product(product, product_id!));
        });
        arr = [];
        num = 1;
      }
    }
  }

  Widget getTextWidgets(List<String> strings) {
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Text(""),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                title: Text(
                  'All TickTic',
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
                  onPressed: () {
                    Navigator.pop(context);
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
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      width: 368,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, 0),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(5, 0),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search_sharp,
                            color: Color(0xFFFFC34A),
                          ),
                          hintText: "Search TickTic",
                          border: InputBorder.none,
                          // hintStyle: TextStyle(
                          //   color: Colors.black,
                          // ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 640,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                            //height: 100,
                            //width: 100,
                            decoration: BoxDecoration(
                                //color: Colors.pink.shade700,
                                //borderRadius: BorderRadius.circular(30),
                                ),
                            child: Container(
                                child: (list_topic.isEmpty)
                                    ? Column(children: [
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
                                      ])
                                    : Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: list_topic.length,
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
                                                  child: Column(children: [
                                                    Text(
                                                        '${list_topic[index].topic}'),
                                                    // Text(
                                                    //     '${list_product[index].product_name}')
                                                    Text(
                                                        '${list_product.length}'),
                                                    Text(
                                                        '${list_product[2].product_id}')
                                                    // Container(
                                                    //     child: ListView.builder(
                                                    //         itemCount:
                                                    //             list_product
                                                    //                 .length,
                                                    //         itemBuilder:
                                                    //             (BuildContext
                                                    //                     context,
                                                    //                 int index) {
                                                    //           return Container(
                                                    //             child: Text(
                                                    //                 '${list_product[index].product_name}'),
                                                    //           );
                                                    //         }))
                                                  ]));
                                            })))),
                      ),
                    ),
                  ),
                  TicBotSheet(size: size),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicBotSheet extends StatefulWidget {
  final Size size;

  TicBotSheet({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<TicBotSheet> createState() => _TicBotSheetState();
}

class _TicBotSheetState extends State<TicBotSheet> {
  Future<Null> insertTickTick({String? topic, List<String>? arr}) async {
    var uuid = Uuid();

    String tick_uid = uuid.v1();
    String member_id = userModels[0].id!;
    String circle_id = circleModels[0].circle_id!;

    String? tick_id;

    // print('###ticktickleghth ' + '$count_ticktickUid');

    // print('#### tick_uid ' + '${tick_uid}');
    // print('#### uid ' + '${member_id}');
    // print('#### topic :' + '${topic}');
    // print('#### arr : ' + '${arr}');
    // print('#### arr : ' + '${arr!.length}');
    String ticklist = arr![0];
    String insertTicklistData =
        '${MyConstant.domain}/famfam/insertTickTick.php?isAdd=true&tick_uid=$tick_uid&circle_id=$circle_id&user_id=$member_id&tick_topic=$topic&ticklist_list=$ticklist';
    await Dio().get(insertTicklistData).then((value) async {
      print('push');
      String pullDataticktick =
          '${MyConstant.domain}/famfam/getTickTickWhereUID.php?isAdd=true&tick_uid=$tick_uid';
      await Dio().get(pullDataticktick).then((value) async {
        for (var item in json.decode(value.data)) {
          ticktick_Model model = ticktick_Model.fromMap(item);
          // print(item);

          setState(() {
            // count_ticktickUid = count_ticktickUid + 1;
            tempticktick.add(model);
            tick_id = model.tick_id;
          });
        }
      }).then((value) async {
        int i = 1;

        print(tick_id);
        for (i; i < arr.length; i++) {
          print('i = ' + '$i');
          String ticklist = arr[i];
          String insertTicklistData =
              '${MyConstant.domain}/famfam/insertTickTickWithID.php?isAdd=true&user_id=$member_id&tick_topic=$topic&ticklist_list=$ticklist&circle_id=$circle_id&tick_uid=$tick_uid&tick_id=$tick_id';
          await Dio().get(insertTicklistData);
        }
      });
      print('inserted ticklist successed');
    });
  }

  final TextEditingController topicController = TextEditingController();

  final TextEditingController listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.size.width * 0.864,
          height: widget.size.height * 0.066,

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
                '+ Add TickTic ',
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
                                    height: widget.size.height * 0.595,
                                    child: Container(
                                      width: widget.size.width * 0.84,
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
                                              'Add TickTic to Circle',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            'Topic',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  widget.size.height * 0.021),
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
                                              child: (TextField(
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
                                                            23.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23.0),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF9EE6D),
                                                        width: 2.0),
                                                  ),
                                                  hintText: 'Ex. Shopping',
                                                  hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                controller: topicController,
                                              )),
                                            )),
                                          ),
                                          SizedBox(
                                              height:
                                                  widget.size.height * 0.021),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Listing",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(
                                                    height: widget.size.height *
                                                        0.021),
                                                Container(
                                                  child: (TextField(
                                                    textAlignVertical:
                                                        TextAlignVertical.top,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        height: 1.5),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      // contentPadding:
                                                      //     EdgeInsets.symmetric(
                                                      //         vertical: 10,
                                                      //         horizontal: 20),

                                                      //border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFF9EE6D),
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFF9EE6D),
                                                            width: 2.0),
                                                      ),
                                                      hintText:
                                                          'Ex. มาม่า, สบู่, ไข่, นม',
                                                      hintStyle: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    controller: listController,
                                                  )),
                                                ),
                                                SizedBox(
                                                    height: widget.size.height *
                                                        0.04),
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
                                                      print('##Topic : ' +
                                                          topicController.text);
                                                      print('##List : ' +
                                                          listController.text);
                                                      var list_text =
                                                          listController.text;
                                                      var arr =
                                                          list_text.split(",");
                                                      print(arr.length);
                                                      insertTickTick(
                                                          topic: topicController
                                                              .text,
                                                          arr: arr);
                                                      Navigator.pop(context);
                                                      listController.text = '';
                                                      topicController.text = '';
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

class VoteRandomBody extends StatefulWidget {
  const VoteRandomBody({Key? key}) : super(key: key);

  @override
  _VoteRandomBodyState createState() => _VoteRandomBodyState();
}

class _VoteRandomBodyState extends State<VoteRandomBody> {
  final List<String> topicPoll = <String>[];
  final List<String> topicRandom = <String>[];
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Stack(
          children: [
            Text(""),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: AppBar(
                  leading: Transform.translate(
                    offset: Offset(0, 12),
                    child: IconButton(
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
                      "Vote & Random",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
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
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.shade400,
                                  //     blurRadius: 5.0,
                                  //     offset: Offset(0, 3),
                                  //   ),
                                  // ],
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
                                  Tab(text: 'Vote'),
                                  Tab(text: 'Random'),
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
                                    height: MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 560,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.864,
                                          decoration: BoxDecoration(
                                              // color: Colors.pink.shade200,
                                              //borderRadius: BorderRadius.circular(30),
                                              ),
                                          child: Builder(builder: (context) {
                                            return topicPoll.isEmpty
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                        "No POLL is going on right now.",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: topicPoll.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Text('bruh');
                                                    },
                                                  );
                                          }),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.66,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.864,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFFF9EE6D)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.0),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Create poll',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  openDialogPoll(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 560,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.864,
                                          decoration: BoxDecoration(
                                              // color: Colors.pink.shade200,
                                              //borderRadius: BorderRadius.circular(30),
                                              ),
                                          child: Builder(builder: (context) {
                                            return topicRandom.isEmpty
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                        "No RANDOM is going on right now.",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        topicRandom.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Text('bruh');
                                                    },
                                                  );
                                          }),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.66,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.864,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFFF9EE6D)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.0),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Create Random',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  openDialogRandom(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}

Future openDialogPoll(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      bool check123 = false, check1234 = false;
      TextEditingController topicController = TextEditingController();
      TextEditingController option1Controller = TextEditingController();
      TextEditingController option2Controller = TextEditingController();
      TextEditingController option3Controller = TextEditingController();
      TextEditingController option4Controller = TextEditingController();
      TextEditingController option5Controller = TextEditingController();
      return StatefulBuilder(builder: (context, setState) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          'Create Poll',
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
                  SizedBox(height: 15),
                  Text(
                    'Topic',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Start -- TextField Topic
                  TextFormField(
                    controller: topicController,
                    minLines: 3,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Enter a poll question',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Topic

                  SizedBox(height: 20),
                  // Text(
                  //   'Options',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(height: 10),

                  // Start -- TextField Option 1
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          option2Controller.text.isNotEmpty &&
                          option3Controller.text.isNotEmpty) {
                        setState(
                          () {
                            check123 = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            check123 = false;
                          },
                        );
                      }
                    },
                    controller: option1Controller,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Option 1',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Option 1

                  SizedBox(height: 15),

                  // Start -- TextField Option 2
                  TextFormField(
                    onChanged: (value) {
                      if (option1Controller.text.isNotEmpty &&
                          value.isNotEmpty &&
                          option3Controller.text.isNotEmpty) {
                        setState(
                          () {
                            check123 = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            check123 = false;
                          },
                        );
                      }
                    },
                    controller: option2Controller,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Option 2',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Option 2

                  SizedBox(height: 15),

                  // Start -- TextField Option 3
                  TextFormField(
                    onChanged: (value) {
                      if (option1Controller.text.isNotEmpty &&
                          option2Controller.text.isNotEmpty &&
                          value.isNotEmpty) {
                        setState(
                          () {
                            check123 = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            check123 = false;
                          },
                        );
                      }
                    },
                    controller: option3Controller,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Option 3',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Option 3

                  SizedBox(height: 15),

                  // Start -- TextField Option 4
                  Visibility(
                    visible: check123,
                    child: TextFormField(
                      onChanged: (value) {
                        if (check123 == true && value != null) {
                          setState(
                            () {
                              check1234 = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              check1234 = false;
                            },
                          );
                        }
                      },
                      controller: option4Controller,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 20, height: 1.5),
                      decoration: InputDecoration(
                        hintText: 'Option 4',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        //border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 190, 190, 186),
                              width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide:
                              BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  // End -- TextField Option 4

                  SizedBox(height: 15),

                  // Start -- TextField Option 5
                  Visibility(
                    visible: check1234,
                    child: TextFormField(
                      controller: option5Controller,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 20, height: 1.5),
                      decoration: InputDecoration(
                        hintText: 'Option 5',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        //border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 190, 190, 186),
                              width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide:
                              BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  // End -- TextField Option 5

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.066,
                        width: MediaQuery.of(context).size.width * 0.864,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF9EE6D)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            if (option1Controller.text != null) {
                              if (option2Controller != null) {
                                if (option3Controller != null) {}
                              }
                            }
                            Navigator.pop(context);
                          },
                        ),
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

Future openDialogRandom(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      bool check123 = false, check1234 = false;
      TextEditingController topicController = TextEditingController();
      TextEditingController option1Controller = TextEditingController();
      TextEditingController option2Controller = TextEditingController();
      TextEditingController option3Controller = TextEditingController();
      TextEditingController option4Controller = TextEditingController();
      TextEditingController option5Controller = TextEditingController();
      return StatefulBuilder(builder: (context, setState) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          'Create Random',
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
                  SizedBox(height: 15),
                  Text(
                    'Topic',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Start -- TextField Topic
                  TextFormField(
                    controller: topicController,
                    minLines: 3,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Enter a random problem',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Topic

                  SizedBox(height: 40),
                  // Text(
                  //   'Options',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(height: 10),

                  // Start -- TextField Option 1
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          option2Controller.text.isNotEmpty &&
                          option3Controller.text.isNotEmpty) {
                        setState(
                          () {
                            check123 = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            check123 = false;
                          },
                        );
                      }
                    },
                    controller: option1Controller,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Option 1',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Start -- TextField Option 2
                  TextFormField(
                    onChanged: (value) {
                      if (option1Controller.text.isNotEmpty &&
                          value.isNotEmpty &&
                          option3Controller.text.isNotEmpty) {
                        setState(
                          () {
                            check123 = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            check123 = false;
                          },
                        );
                      }
                    },
                    controller: option2Controller,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Option 2',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Option 2

                  SizedBox(height: 10),

                  // Start -- TextField Option 3
                  TextFormField(
                    onChanged: (value) {
                      if (option1Controller.text.isNotEmpty &&
                          option2Controller.text.isNotEmpty &&
                          value.isNotEmpty) {
                        setState(
                          () {
                            check123 = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            check123 = false;
                          },
                        );
                      }
                    },
                    controller: option3Controller,
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'Option 3',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 190, 190, 186),
                            width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                      ),
                    ),
                  ),
                  // End -- TextField Option 3

                  SizedBox(height: 10),

                  // Start -- TextField Option 4
                  Visibility(
                    visible: check123,
                    child: TextFormField(
                      onChanged: (value) {
                        if (check123 == true && value != null) {
                          setState(
                            () {
                              check1234 = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              check1234 = false;
                            },
                          );
                        }
                      },
                      controller: option4Controller,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 20, height: 1.5),
                      decoration: InputDecoration(
                        hintText: 'Option 4',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        //border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 190, 190, 186),
                              width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide:
                              BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  // End -- TextField Option 4

                  SizedBox(height: 10),

                  // Start -- TextField Option 5
                  Visibility(
                    visible: check1234,
                    child: TextFormField(
                      controller: option5Controller,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 20, height: 1.5),
                      decoration: InputDecoration(
                        hintText: 'Option 5',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        //border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 190, 190, 186),
                              width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                          borderSide:
                              BorderSide(color: Color(0xFFF9EE6D), width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  // End -- TextField Option 5

                  SizedBox(height: 10),
                  // End -- TextField Option 1

                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.066,
                        width: MediaQuery.of(context).size.width * 0.864,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF9EE6D)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            if (option1Controller.text != null) {
                              if (option2Controller != null) {
                                if (option3Controller != null) {}
                              }
                            }
                            Navigator.pop(context);
                          },
                        ),
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

Future descDialog(BuildContext context, String title, String desc) =>
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
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          // Positioned(
                          //   right: 0,
                          //   top: -6,
                          //   child: InkResponse(
                          //     onTap: () {
                          //       Navigator.of(context).pop();
                          //     },
                          //     child: CircleAvatar(
                          //       child: Icon(
                          //         Icons.close,
                          //         color: Colors.black,
                          //         size: 30,
                          //       ),
                          //       backgroundColor: Colors.transparent,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.height * 0.5,
                        height: MediaQuery.of(context).size.height * 0.15,
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
                              top: 15, left: 15, right: 15, bottom: 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              desc,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.066,
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
