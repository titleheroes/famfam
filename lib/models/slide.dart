import 'package:flutter/cupertino.dart';

class Slide{

  final String image;
  final String title;
  final String title2;

  Slide({
   required this.image, 
   required this.title,
   required this.title2,
  });

}

final slideList = [

  Slide(
    image: 'assets/images/Welcome-1ToDoList.png',
    title: 'Enjoy your day',
    title2: 'Manage your life!'
  ),
  Slide(
    image: 'assets/images/Welcome-2Task.png', 
    title: 'Never forget', 
    title2: 'Have fun with task!'
  ),
  Slide(
    image: 'assets/images/Welcome-3Checkin.png', 
    title: 'Keep Fam know', 
    title2: 'Throw yourself!'
  )
];