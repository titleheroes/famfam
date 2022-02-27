import 'package:famfam/register_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  final ScrollController? scrollController;
  final String? nameForCheckin;
  final String? addressCheckin;
  final String? timeCheckin;
  TabWidget({
    Key? key,
    @required this.scrollController,
    @required this.nameForCheckin,
    @required this.addressCheckin,
    @required this.timeCheckin,
  }) : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  List<String> profile = <String>[
    'J-Profile.png',
    'J-Profile.png',
    'J-Profile.png',
  ];

  List<String> names = <String>[
    'Janejira',
    'Martin',
    'Mia',
  ];

  List<String> addressHistory = <String>[
    "KMUTT",
    "The Mall Bangkae",
    "Soi Bean Factory"
  ];

  List<String> time = <String>['10:45', '10:30', '08:57'];

  void addItemToList() {
    setState(() {
      names.insert(0, widget.nameForCheckin!);
      addressHistory.insert(0, widget.addressCheckin!);
      time.insert(0, widget.timeCheckin!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      controller: widget.scrollController,
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
        SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: names.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      Row(
                        children: <Widget>[
                          // Padding(padding: EdgeInsets.only(left: 0)),
                          Container(
                            child: Image.asset(
                              'assets/images/J-Profile.png',
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.amber,
                                  // width: 280,
                                  child: new Text(
                                    // widget.nameForCheckin!,
                                    '${names[index]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      // widget.addressCheckin!,
                                      '${addressHistory[index]}',
                                      style: TextStyle(fontSize: 13),
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 2)),
                          Row(
                            children: [
                              Text(
                                '${time[index]}',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              Padding(padding: EdgeInsets.only(right: 10)),
                              Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.gps_fixed,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),

                          Padding(padding: EdgeInsets.only(right: 2)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10))
                    ]);
                  }))
        ])),
      ],
    );
  }
}
