import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleLoader extends StatelessWidget{
  const CircleLoader({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(child: SizedBox(
      height: 75,
      width: 75,
      child: CircularProgressIndicator(
      strokeWidth: 8,
      valueColor: AlwaysStoppedAnimation<Color>
        (Color(0xFFF9EE6D)),

    )),);

  }

}