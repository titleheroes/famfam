import 'package:famfam/circleScreen/createCricle/random_id.dart';
import 'package:famfam/circleScreen/inputCircle/inputCircleScreen.dart';
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
        Row(children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 40.0, right: 15.0),
                child: Divider(
                  color: Color(0xff8B8A85),
                  height: 45,
                  thickness: 2,
                )),
          ),
          Text(
            "OR",
          ),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 15.0, right: 40.0),
                child: Divider(
                  color: Color(0xff8B8A85),
                  height: 45,
                  thickness: 2,
                )),
          ),
        ]),
        Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If you have Circle ID ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => InputCircleScreen()));

                  },
                  child: Text('Click here!',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      )),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  ),
                ),
              ],
            )),
        SizedBox(height: 170),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Container(
                    color: Colors.blue,
                    width: 100,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.1 - 37,
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
                        onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Random_id()));

                        },
                        child: Text(
                          "Create",
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
