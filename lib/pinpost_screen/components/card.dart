import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class pincard extends StatelessWidget {
  final String? author;
  final String? textdesc;
  pincard({ Key? key, this.author , this.textdesc }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
    Size size = MediaQuery.of(context).size;
    return Container(
      
      width: size.width * 0.85,
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      margin: EdgeInsets.only(
        bottom: 20,
      ),

      decoration: BoxDecoration(
        color: Color(0xFFF9F6C6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Image.asset("assets/images/J-Profile.png",width: 40, height: 40,),
          Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(author ?? 'Me',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.25,
            ),
            child: Text(formattedDate,style: TextStyle(color:Colors.black.withOpacity(0.5)), ),
          )

        ],),
        

        Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Text(textdesc ?? 'Undefined Pinpost',
          style: TextStyle(fontSize: 18,height: 1.5),),
        ),


      ],)
    );
  }
}