import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/pinpost_screen/components/pinbottomsheet.dart';
import 'package:famfam/pinpost_screen/components/adder.dart';
import 'package:famfam/pinpost_screen/components/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:famfam/Homepage/tabbar.dart';
import 'dart:math';
import 'package:famfam/Homepage/date.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double value = 0;
  final List<String> post = <String>[];
  

  TextEditingController nameController = TextEditingController();
  

  @override
  void initState() {
    //uid = user.uid;
    super.initState();
  }

  void addItemToList() {
    setState(() {
      post.insert(0, nameController.text);
      
    });
  }

  Widget build(BuildContext context){
    //final List<String> author = <String>['Me', 'Me'];
    final User user = FirebaseAuth.instance.currentUser!;
    final List<String> names = <String>['Something Big', 'Something Smol'];
    TextEditingController nameController = TextEditingController();

    void addItemToList() {
      setState(() {
        names.insert(1, nameController.text);
      });
    }

    void onDismissed(int index) {
    setState(() {
      names.removeAt(index);
    });
  }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //Main Screen
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage(user)));
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
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          //color: Colors.pink,
          width: double.infinity,
          
          padding: EdgeInsets.only(
            top: 20,
            left: 24,
            right: 24,
            
          
            
          ),
          child: Center(
            child: Stack(
              children: [
                Column(children: [
                  
                  Expanded(
                    child: ListView(children: [
                      pincard(),
                      pincard(),
                      // pincard(),
                      // pincard(),
                      // pincard(),
                    ],),
                  )
                  
          
                ],),
                Positioned(
                  bottom: 24,
                  left: 15,
                  child: PinBotSheet(size: size,),
                  
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
