// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, use_key_in_widget_constructors

import 'package:famfam/Homepage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/components/text_field_container.dart';
import 'package:famfam/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/components/circlebottomsheet.dart';
import 'package:famfam/components/tickbottomsheet.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import 'header_circle.dart';

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

class TodoBody extends StatelessWidget {
  const TodoBody({Key? key}) : super(key: key);

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
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
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
                                        ///////////////////////////////////////////////////
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Container(
                                              height: 70,
                                              width: 350,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xfffFFC34A)),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: RoundCheckBox(
                                                      uncheckedColor:
                                                          Colors.white,
                                                      checkedColor: Colors.grey,
                                                      onTap: (selected) {},
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 10, 5, 5),
                                                    child: Image.asset(
                                                      "assets/images/Profile.png",
                                                      width: 60,
                                                      height: 60,
                                                    ),
                                                  ),
                                                  const VerticalDivider(
                                                    width: 20,
                                                    thickness: 1.5,
                                                    indent: 15,
                                                    endIndent: 15,
                                                    color: Colors.white,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Container(
                                                      //   width: 230,
                                                      //   child: Text(
                                                      //     "Martin",
                                                      //     style: TextStyle(
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .normal,
                                                      //         fontSize: 15),
                                                      //   ),
                                                      // ),
                                                      // Container(
                                                      //   width: 230,
                                                      //   child: Text(
                                                      //     "รดน้ำต้นไม้ให้พ่อด้วยฮะมุง",
                                                      //     style: TextStyle(
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .normal,
                                                      //         fontSize: 18),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        ///////////////////////////////////////////////////
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CircleBotSheet(size: size),
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
}

class TickBody extends StatelessWidget {
  const TickBody({Key? key}) : super(key: key);

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
            body: Column(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TicBotSheet(size: size),
              ],
            ),
          ),
        ],
      ),
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
                        Navigator.pop(context);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage(user)));
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
                                            color: Colors.pink.shade200,
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
                                            color: Colors.pink.shade200,
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
                                                        "No Random is going on right now.",
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
      return AlertDialog(
        content: StatefulBuilder(builder: (context, setState) {
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          //border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 190, 190, 186),
                                width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(
                                color: Color(0xFFF9EE6D), width: 2.0),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          //border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 190, 190, 186),
                                width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(
                                color: Color(0xFFF9EE6D), width: 2.0),
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
        }),
      );
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
                  // End -- TextField Option 1

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
