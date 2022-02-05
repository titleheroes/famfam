

import 'package:famfam/HomeScreen.dart';
import 'package:famfam/model/slide.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliderItem extends StatelessWidget {

  final int index;

  SliderItem(this.index);
  
  
  @override
  Widget build(BuildContext context){
    return Container(
            child: Stack(
              children: [

                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  
                  child: Image.asset(slideList[index].image),

                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                    ),
                    image: DecorationImage(
                      image: AssetImage(slideList[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 50, 0, 0),
                  child:  Text(slideList[index].title, 
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      
                    ),
                  
                  ),
                ),
               Container(
                 padding: EdgeInsets.fromLTRB(50, 100, 0, 0),
                 child: Text(slideList[index].title2,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  
                  ),
                ),
               ),
              Positioned(
                bottom: 100,
                left: 90,
                child: SizedBox(
                  width: 250,
                  height: 50,
                 
                  child: ElevatedButton(
                    child: Text("Get Start!"),
                    onPressed: () { 
                      Navigator.push(context, MaterialPageRoute(builder:
                      (context) => HomeScreen()));
                                          
                    },
                  ),
                  
                ) 
              ),
                
              

                
                
               
              ],
            )
           
           
          );

  }

  
}