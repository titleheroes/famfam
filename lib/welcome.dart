import 'package:famfam/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/auth.dart';
import '../widgets/slide_dots.dart';
import '../models/slide.dart';
import '../widgets/slide_item.dart';

class Welcome extends StatefulWidget {
  @override
  _Welcome1State createState() => _Welcome1State();
}

class _Welcome1State extends State<Welcome> {
  int _currentPage = 0;
  final AuthService _auth = AuthService();
  final PageController _pageController = PageController(initialPage: 0);

  // @override
  // void initState(){
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     if(_currentPage < 2){
  //       _currentPage++;
  //     }
  //     else{
  //       _currentPage = 0;
  //     }

  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: Duration(microseconds: 300),
  //       curve: Curves.easeIn,
  //     );

  //   });
  // }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // @override
  // void dispose(){
  //   super.dispose();
  //   _pageController.dispose();
  // }

  @override
  // void initState() {
  //   super.initState();
  //   checkAuth(context);
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: slideList.length,
                  itemBuilder: (ctx, i) => SliderItem(i),
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (int i = 0; i < slideList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Future checkAuth(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Already singed-in with");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => MyHomePage(user)));
    }
  }
}
