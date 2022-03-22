import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:famfam/services/my_constant.dart';



class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _BodyState();
}

class _BodyState extends State<PinScreen> {
  double value = 0;
  
  final List<String> names = <String>['Dummy Pin Post Right Here!', ];
  
 
  TextEditingController pinController = TextEditingController();
  
  void addItemToList() {
    setState(() {
      names.insert(0,pinController.text);
      
    });
  }

  void onDismissed(int index) {
    setState(() {
      names.removeAt(index);
    });
  }

  Future getPinpostFromCircle(String input_circle_id) async{
    String circle_id = input_circle_id;
    print('## circle_id = $circle_id');
    String path = '${MyConstant.domain}/famfam/getPinWhereCircleID.php?isAdd=true&circleID_pinpost=$circle_id';
    await Dio().get(path).then((value) => print('## Value ==>> $value'));
  }

  void SendPinText(String input_pin_text)async {
    String pin_text = input_pin_text;
    print('## text = $pin_text');

    String InsertPinpost = '${MyConstant.domain}/famfam/insertPin.php?isAdd=true&pin_text=$pin_text&author_id=1&circle_id=1' ;

    await Dio().get(InsertPinpost).then((value) {
      if(value.toString()=='true'){
        print('Pinpost Inserted');
      }else{
        print('Insert Error');
      }
    });
  }


  Future<void> _displayTextInputDialog(BuildContext context,int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Are you sure you want to delete this Pin Post?'),
          

          actions: <Widget>[
            
            Center(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          
                          minimumSize: Size(150, 40),
                          backgroundColor: Color.fromARGB(255, 139, 139, 139),
                          alignment: Alignment.center,
                        ),
                        child: Text('Cancel',style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        
                        minimumSize: Size(150, 40),
                        backgroundColor: Color.fromARGB(255, 248, 102, 102),
                        alignment: Alignment.center,
                      ),
                      child: Text('Delete',style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        onDismissed(index);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  

  Widget build(BuildContext context){
    
    final User user = FirebaseAuth.instance.currentUser!;
    
    TextEditingController pinController = TextEditingController();

    void addItemToList() {
      setState(() {
      names.insert(0,pinController.text);
      print(names);
    });
    }

    

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      //Main Screen
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          leading: Transform.translate(
            offset: Offset(0, 12),
            child: IconButton(
              icon: Icon(
                Icons.navigate_before_rounded,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage(user)));
              },
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Transform.translate(
            offset: Offset(0, 12),
            child: Text(
              "Pin Post",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),



      body: SafeArea(
        child: Container(
          //color: Colors.pink,
          width: double.infinity,
          
          padding: EdgeInsets.only(
            top: 20,
            left: 24,
            right: 24,
            

            
          ),
          child: Center(
            child: Stack(
              children: [
                Column(children: [



 Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return 
                
                Stack(
                  children: [
                    
                    Container(
                    
                    width: size.width * 0.85,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 24,
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                              
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 245, 181),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(children: [
                            Image.asset("assets/images/J-Profile.png",width: 40, height: 40,),
                            Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text('Me',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  
                            ),
                            Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.225,
                                  ),
                                  child: Text(formattedDate,style: TextStyle(color:Colors.black.withOpacity(0.5)), ),
                            )
                                  
                          ],),
                          
                                  
                          Padding(
                            padding: EdgeInsets.only(
                                  top: 10,
                            ),
                            child: Text('${names[index]}',
                            style: TextStyle(fontSize: 18,height: 1.5),),
                          ),
                                  
                                  
                        ],),
                      ],
                    )
                  ),
                  Positioned( 
                    right: 0,
                    top: 0,
                    child: IconButton(onPressed: () {
                      
                      _displayTextInputDialog(context,index);
                    }, 
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    splashColor: Colors.transparent, 
                    highlightColor: Colors.transparent,  
                    
                    ),
                  ),
                  ],
                );
              }
            )
          )

          
                ],),
                Positioned(
                  bottom: 24,
                  left: 15,
                  child:  //bottomsheet
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.8,
                      height: size.height * 0.066,

                      //color: Colors.pink,

                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF9EE6D)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Pin your Post!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {


                            
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(62.0))),
                              backgroundColor: Colors.white,
                              context: context,
                              isScrollControlled: true,
                              enableDrag: false,
                              builder: (context) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Container(
                                          height: size.height * 0.595,
                                          child: Container(
                                            width: size.width * 0.84,
                                            decoration: BoxDecoration(
                                                //color: hexToColor("#F1E5BA"),
                                                borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(66),
                                              topRight: Radius.circular(66),
                                            )),
                                            child: Column(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 45),
                                                Center(
                                                  child: Text(
                                                    'Add Pin Post',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(height: 30),
                                                Text(
                                                  'What\'s on your mind',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.021),
                                                Container(
                                                  //margin: EdgeInsets.only(top: 40),
                                                  //width: size.width * 0.831,

                                                  child: (Container(
                                                    decoration: BoxDecoration(
                                                      //color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      // boxShadow: [
                                                      //   const BoxShadow(
                                                      //     color: Colors.black,
                                                      //   ),
                                                      // ]
                                                    ),
                                                    //height: 300,
                                                    child: (TextField(
                                                      controller:
                                                          pinController,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: 8,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          height: 1.5),
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        20),
                                                        //border: InputBorder.none,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFF9EE6D),
                                                              width: 2.0),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFFF9EE6D),
                                                              width: 2.0),
                                                        ),
                                                        hintText:
                                                            'Write your Pin Post',
                                                        hintStyle: TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                    )),
                                                  )),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.021),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //SizedBox(height: size.height * 0.021),

                                                      SizedBox(
                                                          height: size.height *
                                                              0.007),
                                                      Center(
                                                          child: Container(
                                                        width: 208,
                                                        height: 60,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Color(
                                                                            0xFFF9EE6D)),
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            90.0),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            print('Input: ' + pinController.text);
                                                            getPinpostFromCircle(pinController.text);
                                                            //SendPinText(pinController.text);
                                                            //addItemToList();
                                                            
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            "Confirm",
                                                            style: TextStyle(
                                                                fontSize: 21,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );


                          }),
                    )
                  ],
                )
                  
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

