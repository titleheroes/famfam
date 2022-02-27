import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  String? nameProfileMember;
  String? idProfileMember;
  String? personIDProfileMember;
  final int? profileUser;
  final int? profileMem;
  final int? profileOwner;
  // String? bdProfileMember;
  // String? phoneProfileMember;
  // String? addressProfileMember;
  // String? jobProfileMember;
  // String? profileProfileMember;
  Profile({
    Key? key,
    @required this.nameProfileMember,
    @required this.idProfileMember,
    @required this.personIDProfileMember,
    @required this.profileMem,
    @required this.profileOwner,
    @required this.profileUser,
    // @required this.bdProfileMember,
    // @required this.phoneProfileMember,
    // @required this.addressProfileMember,
    // @required this.jobProfileMember,
    // @required this.profileProfileMember,
  }) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String profile = 'assets/images/Burin-Profile.png';
  String name = 'Burin Sabaidee';
  String userID = '00000000002';
  String birthday = '21 January 2006';
  String PersonId = '1100098765421';
  String phone = '+66 98 765 4321';
  String address = '101 Royal Village Ram Road Bangkok 10101';
  String job = 'Student';

  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            if (widget.profileOwner == 1 || widget.idProfileMember == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => memberPage()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settingPage()));
            }
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFFF6E5C7),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color(0xFFF6E5C7),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(profile),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              width: 8, color: const Color(0xFFFFFFFF))),
                    )),
                Positioned(
                    bottom: 0,
                    right: 150,
                    child: Container(
                        width: 60,
                        height: 60,
                        child: ElevatedButton(
                          child: Icon(
                            Icons.autorenew_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(CircleBorder()),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.white)),
                          onPressed: () {},
                        )))
              ],
            ),
            Column(
              children: [
                Text(name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                Text(
                  'ID: ' + '$userID',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                headtoppic("Birthdate", birthday),
                headtoppic("Personal ID", PersonId),
                headtoppic("Phone number", phone),
                headtoppic("Address", "xxxxxxxxxxxxx"),
                headtoppic("Job", job),
              ],
            ),
            CheckUser(
                widget.profileUser!, widget.profileMem!, widget.profileOwner!),
          ],
        ),
      ),
    ));
  }

  Widget headtoppic(String Head, String Info) => Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 30)),
          Text(Head,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          Spacer(),
          Container(
            child: Text(
              Info,
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              maxLines: 3,
              overflow: TextOverflow.clip,
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey[500],
            size: 30,
          ),
          Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ));
  Widget CheckUser(
    int profileUser,
    int profileMem,
    int profileOwner,
  ) =>
      Container(
          child: profileMem == 1
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 50),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Center(
                      child: Text(
                    'This is member',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFA3A3),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                )
              : profileOwner == 1
                  ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 50),
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Center(
                          child: Text('This is Owner',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFA3A3),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    )
                  : Container());
}
