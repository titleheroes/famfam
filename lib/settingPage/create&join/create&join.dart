import 'package:flutter/material.dart';

class CreateAndJoinCircle extends StatefulWidget {
  @override
  State<CreateAndJoinCircle> createState() => _CreateAndJoinCircleState();
}

class _CreateAndJoinCircleState extends State<CreateAndJoinCircle> {
  bool _expanded = false;

  TextEditingController CreateCircleController = TextEditingController();
  TextEditingController JoinCircleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ExpansionPanelList(
        elevation: 0,
        animationDuration: Duration(milliseconds: 500),
        children: [
          ExpansionPanel(
            backgroundColor: Colors.grey[200],
            headerBuilder: (context, isExpanded) {
              return ListTile(
                  title: Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Create or Join Circle here',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ));
            },
            body: ListTile(
              title: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('Create Circle',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 25, right: 25),
                          child: TextField(
                              controller: CreateCircleController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: 'Type your Circle name',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[500])))),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFFC34A), elevation: 0),
                            child: Text(
                              'Create Circle',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Divider(
                          height: 20,
                          thickness: 3,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('Join Circle'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 25, right: 25),
                          child: TextField(
                              controller: JoinCircleController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade500),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Type your Circle code',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[500])))),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFFC34A),
                                // padding:
                                //     EdgeInsets.fromLTRB(20, 20, 0, 10),
                                elevation: 0),
                            child: Text(
                              'Join Circle',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          ),
        ],
        // dividerColor: Colors.grey,
        expansionCallback: (panelIndex, isExpanded) {
          _expanded = !_expanded;
          setState(() {});
        },
      ),
    );
  }
}
