import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/pinpost_screen/components/pinbottomsheet.dart';
import 'package:famfam/pinpost_screen/components/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/Homepage/tabbar.dart';
import 'dart:math';
import 'package:famfam/Homepage/date.dart';
import 'package:intl/intl.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _BodyState();
}

class _BodyState extends State<PinScreen> {
  double value = 0;
  final List<String> post = <String>[];
  

  TextEditingController nameController = TextEditingController();
  

  @override
  

  void addItemToList() {
    setState(() {
      post.insert(0, nameController.text);     
    });
  }

  Widget build(BuildContext context){
    //final List<String> author = <String>['Me', 'Me'];
    final User user = FirebaseAuth.instance.currentUser!;
    final List<String> post = <String>['Latin words, consectetur, cites of the word, discovered the undoubtable source','smol','aaa'];
    TextEditingController nameController = TextEditingController();

    void addItemToList() {
      setState(() {
        post.insert(0, nameController.text);
        
      });
    }

    Future<void> _displayTextInputDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    
    
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
          backgroundColor: Colors.white,
          title: Text('Add Pin Post'),
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "What\'s on your mind",
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),

          actions: <Widget>[
            Row(
              children: [
                
              ],
            ),
            Row(
              children: [
                
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.amber,
                  child: Text('Add'),
                  onPressed: () {
                    addItemToList();
                    
                    print(nameController.text);
                    print(post);
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
                fontWeight: FontWeight.bold
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


                  tabbar(),


                  Expanded(
                    child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: post.length,
                    itemBuilder:
                    (BuildContext context,int index) {
                      return pincard(textdesc: '${post[index]}',);
                    }
                                           
                    ),
                  ),
                  
          
                ],),
                Positioned(
                  bottom: 24,
                  left: 15,
                  child:  //bottomsheet
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.8,
                      height: size.height * 0.066,

                      //color: Colors.pink,

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
                            'Pin your Post!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            _displayTextInputDialog(context);

                          }),
                    )
                  ],
                )
                  
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
