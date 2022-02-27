import 'package:flutter/material.dart';
import 'package:famfam/services/service_locator.dart';

class Member {
  String family;
  String member1;
  String member2;
  String member3;
  String member4;
  String profile;
  Member(this.family, this.member1, this.member2, this.member3, this.member4,
      this.profile);
}

class CircleSetting extends StatelessWidget {
  List<Member> circle = [
    Member('one family', 'Janejira', 'Jame', 'John', 'Sam', 'J-Profile.png'),
    Member('two family', 'Burin', 'Bee', 'bwn', 'book', 'J-Profile.png'),
    Member('three family', 'Nigron', 'night', 'note', 'name', 'J-Profile.png'),
    Member('four family', 'Mia', 'Mai', 'May', 'Mind', 'J-Profile.png'),
    Member('five family', 'Arunee', 'Aoy', 'Arm', 'Art', 'J-Profile.png'),
  ];
  List<String> member = ['Sova', 'Jett', 'Sage', 'Kayo'];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: circle.length,
            itemBuilder: (context, index) => buildcircle(
                circle[index], MediaQuery.of(context).size.width / 1.1)));
  }

  Widget buildcircle(Member item, double size) => Container(
      margin: EdgeInsets.only(left: 20, right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF141E27),
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: size,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: Text(
                  item.family,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))),
            Center(
              child: Divider(
                height: 20,
                thickness: 3,
                indent: 0,
                endIndent: 0,
                color: Colors.grey[400],
              ),
            ),
            Row(
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(3, (index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Image.asset(
                              'assets/images/Burin-Profile.png',
                              width: 60,
                            ),
                          ),
                          Text(
                            '${member[index]}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      locator<NavigationService>().navigateTo('members');
                    },
                    child: Text(
                      'See more',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    )),
              ],
            ),
          ]));
}
