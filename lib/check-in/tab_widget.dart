import 'package:famfam/register_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final String? nameForCheckin;
  final String? addressCheckin;

  const TabWidget({
    Key? key,
    @required this.scrollController,
    @required this.nameForCheckin,
    @required this.addressCheckin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      controller: scrollController,
      children: [
        Divider(
          color: Colors.grey,
          height: 30,
          thickness: 4,
          indent: 180,
          endIndent: 180,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) / 4.5),
              child: Image.asset(
                "assets/images/HomeCircleGreen.png",
                width: 35,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              "Family Status",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Column(
          children: [
            Center(
              child: Text(
                "Today",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 12)),
                  Container(
                    child: Image.asset(
                      'assets/images/J-Profile.png',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.amber,
                          // width: 280,
                          child: new Text(
                            nameForCheckin!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              addressCheckin!,
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.gps_fixed,
                      size: 30,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
