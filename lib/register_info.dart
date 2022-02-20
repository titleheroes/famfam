import 'package:famfam/circleScreen/createCricle/body.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register_Info extends StatefulWidget {
  const Register_Info(
      {Key? key, String? emailController, String? passwordController})
      : super(key: key);

  @override
  _Register_InfoState createState() => _Register_InfoState();
}

class _Register_InfoState extends State<Register_Info> {
  late DateTime _dateTime;
  String getText() {
    if (_dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('dd-MM-yyyy').format(_dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EE6D),
      // appBar: AppBar(
      //   title: Text("TorTlew"),
      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -30,
                  left: -65,
                  child: Image.asset("assets/images/block.png"),
                  // child: Text(
                  //   "Hello",
                  //   style: TextStyle(
                  //     fontSize: 32,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ),
                Positioned(
                  top: 100,
                  right: -80,
                  child: Image.asset("assets/images/block2.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 50.0, left: 30.0),
                  child: Text(
                    "\nNow let's get to\nknow each other.\n\n\n\n",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 200.0),
              child: Stack(
                children: [
                  Profile_frame(),
                  Profile_avatar(),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 160.0),
                      width: 360,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          First_name(),

                          Last_name(),

                          Phone_number(),

                          // Birthdate
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Birthdate\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  child: Text(getText()
                                      // _dateTime == null
                                      //       ? "Pick a Date"
                                      //       : formatter.format(_dateTime)
                                      //   _dateTime.toString()
                                      ),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () => pickDate(context),
                                ),
                              ),
                            ],
                          ),

                          Address(),

                          Personal_ID(),

                          Jobs(),

                          Finish_Button(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1940),
        lastDate: DateTime.now());

    if (newDate == null) return;

    setState(() => _dateTime = newDate);
  }
}

class Finish_Button extends StatelessWidget {
  const Finish_Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFAD8002)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              width: 40,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFFFC34A)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
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
                    "Confirm",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Profile_avatar extends StatelessWidget {
  const Profile_avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.black,
            ),
          ),
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Text(
                  "+",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Profile_frame extends StatelessWidget {
  const Profile_frame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 55.0),
      width: MediaQuery.of(context).size.width,
      height: 1140.0,
      decoration: BoxDecoration(
        color: Color(0xFFF1E5BA),
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(65),
          topLeft: Radius.circular(65),
        ),
      ),
    );
  }
}

class Jobs extends StatelessWidget {
  const Jobs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Jobs\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. Student',
            ),
          ),
        ),
      ],
    );
  }
}

class Personal_ID extends StatelessWidget {
  const Personal_ID({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Personal ID\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. 1100432567895',
            ),
          ),
        ),
      ],
    );
  }
}

class Address extends StatelessWidget {
  const Address({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Address\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
            maxLines: 3,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. 77/108 Tashkent Uzbekistan\n      10112',
            ),
          ),
        ),
      ],
    );
  }
}

class Phone_number extends StatelessWidget {
  const Phone_number({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Phone number\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. 0812345678',
            ),
          ),
        ),
      ],
    );
  }
}

class Last_name extends StatelessWidget {
  const Last_name({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Last Name\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. Sabaidee',
            ),
          ),
        ),
      ],
    );
  }
}

class First_name extends StatelessWidget {
  const First_name({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "First Name\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Ex. Janejira',
            ),
          ),
        ),
      ],
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
