import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EnterCircleID(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class EnterCircleID extends StatelessWidget {
  final Widget child;
  const EnterCircleID({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          //padding: EdgeInsets.only(top: ),
          margin: EdgeInsets.symmetric(vertical: 28),
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                )
              ]),
          child: child,
        ),
        SizedBox(height: 300),
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(bottom: ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.1 - 37,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(29),
                      //   // boxShadow: [
                      //   //   BoxShadow(
                      //   //     color: Colors.grey.withOpacity(0.4),
                      //   //     spreadRadius: 1,
                      //   //     offset: Offset(0, 3), // changes position of shadow
                      //   //   ),
                      //   // ],
                      // ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFAD8002)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createCircleScreen()));
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(fontSize: 21, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    width: 100,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.1 - 37,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(25.0),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.grey.withOpacity(0.4),
                      //       spreadRadius: 1,
                      //       offset:
                      //           Offset(0, 3), // changes position of shadow
                      //     ),
                      //   ],
                      // ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFFFC34A)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 21),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }
}
