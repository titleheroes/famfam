import 'package:famfam/pinpost_screen/components/pinbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:famfam/Homepage/menuHome.dart';
import 'package:famfam/Homepage/tabbar.dart';
import 'dart:math';
import 'package:famfam/Homepage/date.dart';

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
                              color: Colors.blue,
                              height: size.height*0.09,
                              child: (Row(
                              children: [

                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
                                  child: Text(
                                    "Pin Post",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
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
                                          
                                        }))



                              ],
                            )),
                            ),
                            SizedBox(height: 20,),

                            
                            Container(
                              width: size.width * 0.85,
                              height: size.height * 0.75,
                              color: Colors.red,
                              child: (SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                  




                                Container(
                                  height: size.height * 0.1,
                                  
                                  //width: size.width *0.3,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 10,),
                                // Container(
                                //   height: size.height * 0.02,
                                //   width: size.width *0.3,
                                //   color: Colors.white,
                                // ),

                              ],)
                              
                              )),


                            ),
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

