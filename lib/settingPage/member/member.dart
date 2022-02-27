import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:famfam/services/service_locator.dart';

class Member {
  int owner;
  String name;
  String profile;
  Member(this.owner, this.name, this.profile);
}

class memberPage extends StatelessWidget {
  String familyname = 'Sabaidee';
  String code = 'ZXCV1857';

  List<Member> member = [
    Member(1, 'Janejira', 'J-Profile.png'),
    Member(0, 'Burin', 'J-Profile.png'),
    Member(0, 'Nigron', 'J-Profile.png'),
    Member(0, 'Mia', 'J-Profile.png'),
    Member(0, 'Arunee', 'J-Profile.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${familyname} " + "Family",
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settingPage()));
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
              padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  Icon(Icons.search),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    'Search',
                  ),
                ],
              ),
            ),
            Column(
                children: List<Widget>.generate(member.length, (int index) {
              return new Container(
                child: checkOwner(
                    '${member[index].owner}',
                    '${member[index].name}',
                    '${member[index].profile}',
                    context),
              );
            })),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Center(
                child: Text(
                  'Invite Code : ' + '${code}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkOwner(String owner, String name, String profile, context) =>
      Container(
          child: (owner == '1')
              ? Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: ElevatedButton(
                      onPressed: () {
                        locator<NavigationService>()
                            .navigateTo('members_in_circle_Owner');
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFF7575),
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))),
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset('assets/images/${profile}'),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                  Text(
                                    'Owner',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                name,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          )
                        ],
                      )))
              : Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      locator<NavigationService>()
                          .navigateTo('members_in_circle_Member');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF80E28D),
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0))),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset('assets/images/${profile}'),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.assignment_ind,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                Text(
                                  'Member',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              name,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  )));
}
