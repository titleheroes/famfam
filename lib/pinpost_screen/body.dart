import 'package:famfam/pinpost_screen/components/pinbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/Homepage/menuHome.dart';
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

  @override
  void initState() {
    //uid = user.uid;
    super.initState();
  }

  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: backgroundColor),
          ),
          SafeArea(child: menuHome()),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 0),
              duration: Duration(milliseconds: 500),
              builder: (___, double val, __) {
                return (Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, -280 * val)
                      ..rotateY(-(pi / 6) * val),
                    child: Scaffold(
                        //Main Screean
                        body: SafeArea(
                            child: Container(
                      child: SingleChildScrollView(
                        child: Container(
                            child: Column(
                          children: [
                            Container(
                              //color: Colors.blue,
                              height: size.height*0.09,
                              child: (Row(
                              children: [

                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
                                  child: Text(
                                    "Pin Post",
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(size.width*0.5, 20, 0, 0),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.menu_open_rounded,
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            value == 0 ? value = 1 : value = 0;
                                          });
                                          print(value);


                                        }))



                              ],
                            )),
                            ),
                            SizedBox(height: 20,),
                            
                            SingleChildScrollView(
                            
                            child: Container(
                              //width: size.width * 0.85,
                              height: size.height * 0.75,
                              //color: Colors.red,
                               child: (SingleChildScrollView(
                               scrollDirection: Axis.vertical,
                              child: Column(children: [
                                  
                                


                                /*  One Card */
                                Container(
                                  
                                  height: size.height * 0.2,
                                  width: size.width *0.85,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1,blurRadius: 10,offset: Offset(4,8), ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFF9F6C6)), 

                                  child: Column(children: [
                                    
                                    Row(children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                        child: ( Image.asset(
                                                        "assets/images/J-Profile.png",width: 40, height: 40, )),
                                      ),
                                     Container(
                                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: (Text("Me",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),)),
                                      ),

                                      Container(
                                        margin: const EdgeInsets.fromLTRB(130, 13, 0, 0),
                                        child: (Text(formattedDate,style: TextStyle(color: Colors.black.withOpacity(0.5)),)),
                                      ),
                                      
                                      

                                    ],
                                      
                                    ),
                                    
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      width: size.width *0.6,
                                      //color: Colors.red,
                                      child: Text('dataaaaaaaaa                           1.เอเอเอเอเอเอเอเอเอ                          2.บีบีบีบีบีบีบีบีบีบีบบีบีบี                       3.ซีซีซีซีซีซีซีซีซีซีซีซีซีซี      '
                                      
                                      ,style: TextStyle(fontSize: 18),),
                                    ),



                                  ],),

                                ),
                                /*  One Card */




                                SizedBox(height: 20,),

                                Container(
                                  height: size.height * 0.15,
                                  width: size.width *0.85,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1,blurRadius: 10,offset: Offset(4,8), ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFF9F6C6)), 
                                ),

                                
  
                              
                             

                              ],)
                              
                              )),


                            )),


                            SizedBox(height: 20,),



                            PinBotSheet(size: size),

                          ],
                        )),
                      ),
                    ))
                    
                    
                    

                    
                    )));
              }),
        ],
      ),
      
      
    
      
      
      
      
    );
  }
}

