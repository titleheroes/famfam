import 'package:famfam/pinpost_screen/components/pinbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
                backgroundColor: Colors.transparent,
                elevation: 0,
                
              ),
            ),

            
            body: Column(
              children: <Widget>[
                Container(
                  
                  //margin: EdgeInsets.only(left: 50.0),
                  child: Text(
                    "All Circle's list",
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      //fontFamily: 'Merriweather',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Container(
                //   color: Colors.orange,
                //   height: 300,
                // ),
                
                //Spacer(),              
                PinBotSheet(size: size),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
