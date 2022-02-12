import 'package:flutter/material.dart';
import 'package:famfam/pinpost_screen/body.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black),
      //   title: Text('Pin Post',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w600),),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,

      // ),
      endDrawer: Drawer(),
      
      body: Body(),
    );
  }
}
