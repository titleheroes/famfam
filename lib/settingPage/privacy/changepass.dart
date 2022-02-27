import 'package:flutter/material.dart';
import 'package:famfam/settingPage/privacy/Privacy.dart';

class ChangePassword extends StatelessWidget {
  TextEditingController OldPassController = TextEditingController();
  TextEditingController NewPassController = TextEditingController();
  TextEditingController RetypePassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyEZ()));
                },
              ),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Old Password",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                      child: TextField(
                          controller: OldPassController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Type your old password',
                              hintStyle: TextStyle(color: Colors.grey[500])))),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 20),
                    child: Text(
                      "New Password",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                      child: TextField(
                          controller: NewPassController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Type your new password',
                              hintStyle: TextStyle(color: Colors.grey[500])))),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 20),
                    child: Text(
                      "Re - type Password",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                      child: TextField(
                          controller: RetypePassController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Re-type your password',
                              hintStyle: TextStyle(color: Colors.grey[500])))),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 5.5,
                          top: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFE3E3E3),
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              elevation: 0),
                          onPressed: () {
                            print(OldPassController.text);
                            print(NewPassController.text);
                            print(RetypePassController.text);
                          },
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )))
                ],
              ),
            )));
  }
}
