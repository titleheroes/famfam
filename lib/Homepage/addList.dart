import 'package:famfam/Homepage/menuHome.dart';
import 'package:flutter/material.dart';

class addList extends StatefulWidget {
  @override
  _addListState createState() => new _addListState();
}

class _addListState extends State<addList> {
  final List<String> names = <String>[
    '1',
    '2',
    '3',
    '4',
    '1',
    '2',
    '3',
    '4',
    '1',
    '2',
    '3',
    '4',
    '1',
    '2',
    '3',
    '4'
  ];

  TextEditingController nameController = TextEditingController();

  void addItemToList() {
    setState(() {
      names.insert(0, nameController.text);
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                addItemToList();
                print(nameController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        RaisedButton(
          child: Text('Add'),
          onPressed: () {
            _displayTextInputDialog(context);
          },
        ),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    // color: msgCount[index] >= 10
                    //     ? Colors.blue[400]
                    //     : msgCount[index] > 3
                    //         ? Colors.blue[100]
                    //         : Colors.grey,
                    child: Center(
                        child: Text(
                      '${names[index]}',
                      style: TextStyle(fontSize: 18),
                    )),
                  );
                }))
      ]),
    );
  }
}
