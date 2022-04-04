import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/models/circle_model.dart';
import 'package:famfam/pinpost_screen/pin_screen.dart';
import 'package:famfam/widgets/circle_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/models/pinpost_model.dart';
import 'package:famfam/models/pinreply_model.dart';
import 'package:famfam/widgets/slide_dots.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ReplyPinScreen extends StatefulWidget {
  String pin_id  ;
  
  
  ReplyPinScreen(this.pin_id) ;

  @override
  State<ReplyPinScreen> createState() => _BodyState();

}

class _BodyState extends State<ReplyPinScreen> {
  

  bool load = true;
  bool? havePinpostData;
  List<UserModel> userModels = [];
  List<PinpostModel> pinpostModels = [];
  List<PinpostReplyModel> pinreplyModels = [];
  
   
  List<String> names = <String>['Dummy Pin Post Right Here!', 'zzzzzzzz', 'ssssss'];
  TextEditingController pinController = TextEditingController();
  


  @override
  void initState(){
    super.initState();
    pullUserSQLID().then((value)  {
      getPinpostFromPinID().then((value) => getPinReplyFromPinID());
    });
    
    print('Reply of ID ==>> '+widget.pin_id);

  }
  
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

Future<Null> pullUserSQLID() async {
    final String getUID = FirebaseAuth.instance.currentUser!.uid.toString();
    String uid = getUID;
    String pullUser =
        '${MyConstant.domain}/famfam/getUserWhereUID.php?isAdd=true&uid=$uid';
    await Dio().get(pullUser).then((value) async {
      if (value.toString() == null ||
          value.toString() == 'null' ||
          value.toString() == '') {
        FirebaseAuth.instance.signOut();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);         
          setState(() {
            userModels.add(model);
            

          });
        }
      }
    });
  }


  Future getPinpostFromPinID() async{
    
    load = true;
    String pin_id = widget.pin_id;
    pinpostModels.clear();
    

    //print('## circle_id = $circle_id');
    String path = '${MyConstant.domain}/famfam/getPinWherePinID.php?isAdd=true&pin_id=$pin_id';
    
    await Dio().get(path).then((value){
      //print(value);
      
      if(value.toString() == 'null'){
        //No Data
        setState(() {
          //load = false;
          havePinpostData = false;
        });

      } else {
        //Have Data
        for (var item in json.decode(value.data)) {
          PinpostModel model = PinpostModel.fromMap(item);
          //print('Pintext ==>> ${model.pin_text} by ${model.fname}' );

          setState(() {
            //load = false;
            havePinpostData = true;
            pinpostModels.add(model);
            DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm").parse(pinpostModels[0].date);
            String formattedDate = DateFormat('dd/MM/yyyy - kk:mm').format(tempDate);
            pinpostModels[0].date = formattedDate;

          } );
        }

      }

    });

  }

  Future getPinReplyFromPinID() async{
    
    load = true;
    String pin_id = widget.pin_id;
    pinreplyModels.clear();
    

    //print('## circle_id = $circle_id');
    String path = '${MyConstant.domain}/famfam/getPinReplyWherePinID.php?isAdd=true&pin_id=$pin_id';
    
    await Dio().get(path).then((getvalue){
      //print(value);
      
      if(getvalue.toString() == 'null'){
        //No Data
        setState(() {
          load = false;
          //haveData = false;
        });

      } else {
        //Have Data
        for (var item in json.decode(getvalue.data)) {
          PinpostReplyModel model = PinpostReplyModel.fromMap(item);
          print('PinReplytext ==>> ${model.pin_reply_text} by ${model.fname}' );

          setState(() {
            load = false;
            //haveData = true;
            pinreplyModels.add(model);
            
            

          } );
        }

      }

    });

  }

  void SendPinReplyText(String input_reply_text)async {
    SharedPreferences preferences = await SharedPreferences.getInstance(); 
    
    String author_id = userModels[0].id!;
    String pin_id = widget.pin_id;
    String pin_reply_text = input_reply_text;
    
    

    String InsertPinReply = '${MyConstant.domain}/famfam/insertPinReply.php?isAdd=true&author_id=$author_id&pin_id=$pin_id&pin_reply_text=$pin_reply_text' ;

    await Dio().get(InsertPinReply).then((value) {
      if(value.toString()=='true'){
        print('PinReply Inserted');
      }else{
        print('Reply Error');
      }
    }
    
  );
    load = true;
    getPinpostFromPinID().then((value) =>  getPinReplyFromPinID().then((value) => load = false));
    //Navigator.pushNamed(context, '/pinpost');

  }

  Future<void> _displayEditDialog(BuildContext context, String pin_id, String pin_text) async {

    TextEditingController pinEditController = TextEditingController();
    pinEditController.text = "${pin_text}";
    print('aaaaaaaaa');
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Edit Pin Post'),
          
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextFormField(
                //initialValue: "${pin_text}",
                controller: pinEditController,
                decoration: InputDecoration(
                  hintText: "${pin_text}",
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),


          actions: <Widget>[
            
            Center(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 2,
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
                  SizedBox(width: 10,),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 2
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        
                        minimumSize: Size(150, 40),
                        backgroundColor: Color.fromARGB(255, 224, 222, 72),
                        alignment: Alignment.center,
                      ),
                      child: Text('Edit',style: TextStyle(color: Colors.white)),
                      onPressed: ()async {


                        print('Edited text = '+pinEditController.text);
                        String EditPinpost = '${MyConstant.domain}/famfam/editPinfromPinID.php?isAdd=true&pin_id=$pin_id&pin_text=${pinEditController.text}' ;
                        await Dio().get(EditPinpost).then((value) {
                            if(value.toString()=='true'){
                              print('Pinpost Edited');
                              getPinpostFromPinID().then((value) =>  getPinReplyFromPinID().then((value) => load = false));
                            }else{
                              print('Edit Error');
                            }
                          }   
                        );
                        
                        
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


  Future<void> _displayReplyEditDialog(BuildContext context, String pin_reply_id, String pin_reply_text) async {

    TextEditingController pinEditController = TextEditingController();
    pinEditController.text = "${pin_reply_text}";
    print('Pin Reply ID ==>> '+pin_reply_id);
    
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Edit Reply'),
          
          content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextFormField(
                //initialValue: "${pin_text}",
                controller: pinEditController,
                decoration: InputDecoration(
                  hintText: "${pin_reply_text}",
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),


          actions: <Widget>[
            
            Center(
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 2,
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
                  SizedBox(width: 10,),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 2
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        
                        minimumSize: Size(150, 40),
                        backgroundColor: Color.fromARGB(255, 224, 222, 72),
                        alignment: Alignment.center,
                      ),
                      child: Text('Edit',style: TextStyle(color: Colors.white)),
                      onPressed: ()async {


                        print('Edited text = '+pinEditController.text);
                        String EditPinpost = '${MyConstant.domain}/famfam/editReplyfromReplyID.php?isAdd=true&pin_reply_text=${pinEditController.text}&pin_reply_id=${pin_reply_id}' ;
                        await Dio().get(EditPinpost).then((value) {
                            if(value.toString()=='true'){
                              print('Pinreply Edited');
                              
                              getPinpostFromPinID().then((value) =>  getPinReplyFromPinID().then((value) => load = false));
                            }else{
                              print('Edit Error');
                            }
                          }   
                        );
                        
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





  Future<void> _displayDeleteDialog(BuildContext context,String pin_id) async {

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

                        DeletePinpost(pin_id);
                        //onDismissed();


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

  void DeletePinpost(String pin_id)async {
    
    String target_pin_id = pin_id;
    String DeletePinpost = '${MyConstant.domain}/famfam/deletePinFromPinID.php?isAdd=true&pin_id=$target_pin_id' ;
    
    print('## target = $target_pin_id');

    await Dio().get(DeletePinpost).then((value) {
      if(value.toString()=='True'){
        print('Pinpost Deleted');
      }else{
        print('Delete Error');
      }
    });
    //Navigator.pushNamed(context, '/pinpost');
    getPinpostFromPinID().then((value) =>  getPinReplyFromPinID().then((value) => load = false));

  }

  Future<void> _displayReplyDeleteDialog(BuildContext context,String pin_reply_id) async {

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Are you sure you want to delete this Reply?'),
          

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

                        DeletePinReply(pin_reply_id);
                        //onDismissed();


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

  void DeletePinReply(String pin_reply_id)async {
    
    String target_pin_id = pin_reply_id;
    String DeletePinpost = '${MyConstant.domain}/famfam/deletePinReplyWherePinReplyID.php?isAdd=true&pin_reply_id=$target_pin_id' ;
    
    print('## target = $target_pin_id');

    await Dio().get(DeletePinpost).then((value) {
      if(value.toString()=='True'){
        print('PinReply Deleted');
        getPinpostFromPinID().then((value) =>  getPinReplyFromPinID().then((value) => load = false));
       
      }else{
        print('Delete Error');
      }
    });
    //Navigator.pushNamed(context, '/pinpost');
    

  }
  

  

  Widget build(BuildContext context){
    
    final User user = FirebaseAuth.instance.currentUser!;
    
    TextEditingController pinController = TextEditingController();

    Size size = MediaQuery.of(context).size;

    


    return new WillPopScope(
      onWillPop: () {

          if(load == false){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PinScreen() ),) ;
          }else{
            null;
          }

        return Future.value(false);

      } ,


      child: Scaffold(
        //Main Screen
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            leading: Transform.translate(
              offset: Offset(0, 12),
              child: load ? null : IconButton(
                icon: Icon(
                  Icons.navigate_before_rounded,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                      builder: (context) => PinScreen(),
                  ));
                  
                },
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Transform.translate(
              offset: Offset(0, 12),
              child: Text(
                "Reply Pin Post",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      
      
      
        body: load ? CircleLoader() : SafeArea(
          child: Container(
            //color: Colors.pink,
            width: double.infinity,
            
            padding: EdgeInsets.only(
              top: 10,
              left: 24,
              right: 24,
              
      
              
            ),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    
                    children: [
      
      
      
          Container(
            //height: 300,
            
            //color: Color.fromRGBO(0, 188, 212, 1),
            child: Stack(
      
                  children: [
      
                    Container(
                    
                    width: size.width ,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 24,
                    ),
                    margin: EdgeInsets.only(bottom: 0),
                              
                    decoration: BoxDecoration(
                      color: Color(0xfffF5EC83),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(children: [
      
                            Container(
                                    
                                    
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          NetworkImage(pinpostModels[0].profileImage),
                                    ),
    
    
                                  ),
      
                            Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text('${pinpostModels[0].fname}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  
                            ),
                            
                            
                          ],),
                          SizedBox(height: 5,),
                          
                          
                          Text(pinpostModels[0].date,style: TextStyle(color:Colors.black.withOpacity(0.5)), ),
                                  
                          Padding(
                            padding: EdgeInsets.only(
                                  top: 10,
                            ),
                            child: Text('${pinpostModels[0].pin_text}',
                            style: TextStyle(fontSize: 18,height: 1.5),),
                          ),     
                        ],),
                      ],
                    ),
      
                
      
                  ),
      
                   
                  
                  if (userModels[0].id == pinpostModels[0].author_id) 
                  
                  Positioned( 
                    right: 0,
                    top: 0,
      
                    child: Row(
                      children: [
      
                        IconButton(onPressed: () {
                          
                          _displayEditDialog(context,pinpostModels[0].pin_id,pinpostModels[0].pin_text);
                        }, 
                        icon: Icon(Icons.edit),
                        iconSize: 30,
                        splashColor: Colors.transparent, 
                        highlightColor: Colors.transparent,  
                        
                        ),
      
                        IconButton(onPressed: () {
                          
                          _displayDeleteDialog(context,pinpostModels[0].pin_id);
                        }, 
                        icon: Icon(Icons.close),
                        iconSize: 30,
                        splashColor: Colors.transparent, 
                        highlightColor: Colors.transparent,  
                        
                        ),
                      ],
      
      
                    ),
      
      
      
                  ),
    
                  
                  ],
                
      
                ),
          ),
      
      
      
            //SizedBox(height: 50,),
            
            Expanded(
              child: Column(
                children: [
                  Container(
                    //height: double.infinity,
                    width: double.infinity,
                    //color: Colors.white,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text('${pinpostModels[0].number_of_reply} Replied',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                        ),
                        
                        ),
                      ),
                  ),
                  ),
    
    
    
                  Expanded(
                    child: Container(
                                height: 50,
                                //color: Color.fromARGB(255, 71, 243, 114),
                                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: pinreplyModels.length,
    
                  
                  
                    itemBuilder: (BuildContext context, int index) {
                      DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm").parse(pinreplyModels[index].date);
                      String formattedDate = DateFormat('dd/MM/yyyy - kk:mm').format(tempDate);
                      
                  
                      return
                      
                        Stack(
                  
                        children: [
                          
                          
                          Container(
                          
                          width: size.width ,
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 24,
                          ),
                  
                        
                      
                          
                  
                          margin: EdgeInsets.only(bottom: index==pinreplyModels.length-1 ? 100 :20),
                                    
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 250, 244, 154),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(children: [
                  
                                  Container(
                                          
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            backgroundImage:
                                                NetworkImage(pinreplyModels[index].profileImage),
                                          ),
                                        ),
                  
                                  Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text('${pinreplyModels[index].fname}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        
                                  ),
                                  
                                        
                                ],),
                                SizedBox(height: 5,),
                                Text(formattedDate,style: TextStyle(color:Colors.black.withOpacity(0.5)), ),
                                        
                                Padding(
                                  padding: EdgeInsets.only(
                                        top: 10,
                                  ),
                                  child: Text('${pinreplyModels[index].pin_reply_text}',
                                  style: TextStyle(fontSize: 18,height: 1.5),),
                                ),
                  
                                
                                
                                        
                                        
                                      
                  
                  
                  
                  
                              ],),
                            ],
                          ),
                  
                      
                  
                        ),
                  
                         
                        
                        if (userModels[0].id == pinreplyModels[index].reply_user_id) 
                        
                        Positioned( 
                          right: 0,
                          top: 0,
                  
                          child: Row(
                            children: [
                  
                              IconButton(onPressed: () {
                                
                                _displayReplyEditDialog(context,pinreplyModels[index].pin_reply_id,pinreplyModels[index].pin_reply_text);
                              }, 
    
                              icon: Icon(Icons.edit),
                              iconSize: 30,
                              splashColor: Colors.transparent, 
                              highlightColor: Colors.transparent,  
                              
                              ),
                  
                              IconButton(onPressed: () {
                                
                                _displayReplyDeleteDialog(context,pinreplyModels[index].pin_reply_id);
                              }, 
                              icon: Icon(Icons.close),
                              iconSize: 30,
                              splashColor: Colors.transparent, 
                              highlightColor: Colors.transparent,  
                              
                              ),
                            ],
                  
                  
                          ),
                  
                  
                  
                        ),
                  
                  
                  
                  
                        ],
                      
                  
                      );
                      
                      
                      
                      
                      
                  
                  
                    }
                  
                    
                  
                  
                  
                  
                                ),
                  
                                
                              ),
                  )
                ],
              ),
            )
            
                  ],
                  
                  ),
                  Positioned(
                    bottom: 20,
                    right: 5,
                    child:  //bottomsheet
                  Stack(
                    children: [
                      Container(
                        //width: size.width * 0.8,
                        width: size.width * 0.3,
                        height: size.height * 0.08,
      
                        //color: Colors.cyan,
      
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 243, 230, 90)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Reply',
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
                                                      'Reply Pin Post',
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
                                                              'Write your Reply',
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
      
                                                              /*----------------- Here ---------------------------------*/ 
                                                              print('Input: ' + pinController.text);
                                                              //print('Current circle_id: ' + circle_id );
                                                              //getPinpostFromCircle(pinController.text);
                                                              SendPinReplyText(pinController.text);
                                                              //addItemToList();
                                                              /*----------------- Here ---------------------------------*/ 
      
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
      
        )
        
      
      
      
      ),
    );
  }
}

