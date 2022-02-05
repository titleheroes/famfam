import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class ID_Field extends StatelessWidget {
  //final String hintText;
  final ValueChanged<String> onChanged;
  const ID_Field({
    //required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CircleID(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          //hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CircleID extends StatelessWidget {
  final Widget child;
  const CircleID({
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
          margin: EdgeInsets.only(top: 40),
          height: size.height * 0.12 - 37,
          width: size.width * 0.75 ,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(hexToColor('#FFFFFF')),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: "APCY2101"));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar
              (content: Text('Copied to clipboard')));

            },
            child: Text(
              "APCY2101",
              style: TextStyle(fontSize: 34,fontWeight: FontWeight.w400, color: hexToColor('#000000')),
            ),
          ),
           
        ),      
        SizedBox(height: 270),
        

        Column(
          
          children: [          
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    
                    child: Container(
                      height: size.height * 0.1 - 37,
                    
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#AD8002')),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => createCircleScreen()));
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(fontSize: 21, color: Colors.white),
                        ),
                      ),
                    ),
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
                              hexToColor('#FFC34A')),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Next",
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
