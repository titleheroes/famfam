import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famfam/login.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/sqlite_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Register_Info extends StatefulWidget {
  const Register_Info({
    Key? key,
    // String? emailController, String? passwordController
  }) : super(key: key);

  @override
  _Register_InfoState createState() => _Register_InfoState();
}

class _Register_InfoState extends State<Register_Info> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;
  String? urlImage;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final String getUID = FirebaseAuth.instance.currentUser!.uid.toString();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController personalIDController = TextEditingController();
  TextEditingController jobsController = TextEditingController();
  DateTime? _dateTime;
  String getText() {
    if (_dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('dd-MM-yyyy').format(_dateTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EE6D),
      // appBar: AppBar(
      //   title: Text("TorTlew"),
      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -30,
                  left: -65,
                  child: Image.asset("assets/images/block.png"),
                  // child: Text(
                  //   "Hello",
                  //   style: TextStyle(
                  //     fontSize: 32,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ),
                Positioned(
                  top: 100,
                  right: -80,
                  child: Image.asset("assets/images/block2.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 50.0, left: 30.0),
                  child: Text(
                    "\nNow let's get to\nknow each other.\n\n\n\n",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            //Profile Frame
            Container(
              margin: const EdgeInsets.only(top: 200.0),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 55.0),
                    width: MediaQuery.of(context).size.width,
                    height: 1140.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E5BA),
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(65),
                        topLeft: Radius.circular(65),
                      ),
                    ),
                  ),

                  //Profile Avatar
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: _imageFile == null
                                ? NetworkImage(
                                        "https://media.discordapp.net/attachments/718002735475064874/946745190062891028/blank_profile.png?width=663&height=663")
                                    as ImageProvider
                                : FileImage(File(_imageFile!.path)),
                          ),
                        ),
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                              onPressed: () {
                                TakePhoto(ImageSource.gallery);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 160.0),
                      width: 360,
                      color: Colors.transparent,
                      child: Column(
                        children: [
//First Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: fnameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. Janejira',
                                  ),
                                ),
                              ),
                            ],
                          ),

//Last Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Last Name\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. Sabaidee',
                                  ),
                                ),
                              ),
                            ],
                          ),

// Phone Number
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Phone number\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. 0812345678',
                                  ),
                                ),
                              ),
                            ],
                          ),

// Birthdate
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Birthdate\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  child: Text(getText()),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () => pickDate(context),
                                ),
                              ),
                            ],
                          ),

// Address
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Address\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: addressController,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText:
                                        'Ex. 77/108 Tashkent Uzbekistan\n      10112',
                                  ),
                                ),
                              ),
                            ],
                          ),

// Personal ID
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Personal ID\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: personalIDController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. 1100432567895',
                                  ),
                                ),
                              ),
                            ],
                          ),

// Jobs
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                "Jobs\n",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: jobsController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Ex. Student',
                                  ),
                                ),
                              ),
                            ],
                          ),

// Finish Button
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 1,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xFFAD8002)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          user!.delete();
                                          await _auth.signOut();
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => Login(),
                                          //   ),
                                          // );
                                          Navigator.popAndPushNamed(
                                              context, '/login');
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    width: 40,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 1,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xFFFFC34A)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await uploadPictureToStorage()
                                              .whenComplete(() async {
                                            if (fnameController != null &&
                                                fnameController != '' &&
                                                lnameController != null &&
                                                lnameController != '' &&
                                                phoneController != null &&
                                                phoneController != '' &&
                                                _dateTime != null &&
                                                addressController != null &&
                                                addressController != '' &&
                                                personalIDController != null &&
                                                personalIDController != '' &&
                                                jobsController != null &&
                                                jobsController != '') {
                                              String uid = getUID;
                                              String profileImage;
                                              if (urlImage == null) {
                                                profileImage =
                                                    'https://media.discordapp.net/attachments/718002735475064874/946745190062891028/blank_profile.png?width=663&height=663';
                                              } else {
                                                profileImage = urlImage!;
                                              }
                                              print(urlImage);
                                              String fname =
                                                  fnameController.text;
                                              String lname =
                                                  lnameController.text;
                                              String phone =
                                                  phoneController.text;
                                              DateTime birth = _dateTime!;
                                              String address =
                                                  addressController.text;
                                              String personalID =
                                                  personalIDController.text;
                                              String jobs = jobsController.text;
                                              UserModel userModel = UserModel(
                                                  uid: uid,
                                                  profileImage: profileImage,
                                                  fname: fname,
                                                  lname: lname,
                                                  phone: phone,
                                                  birth: birth,
                                                  address: address,
                                                  personalID: personalID,
                                                  jobs: jobs);
                                              await SQLiteHelper()
                                                  .insertValueTOSQLite(
                                                      userModel)
                                                  .then((value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        createCircleScreen(),
                                                  ),
                                                );
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please insert all of text above.",
                                                  gravity: ToastGravity.BOTTOM);
                                              print("Blank info");
                                            }
                                          });
                                        },
                                        child: Text(
                                          "Confirm",
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(10000);
    var imageFile;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    if (_imageFile == null) {
      var imageFile = File("/assets/images/prfoile/.blank_profile.png");
    } else {
      imageFile = File(_imageFile!.path);
    }

    Reference storageReference = firebaseStorage
        .ref()
        .child('userProfile/' + fnameController.text + i.toString());

    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() async {
      var url = await storageReference.getDownloadURL();
      setState(() {
        urlImage = url.toString();
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void TakePhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = PickedFile;
    });
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1940),
        lastDate: DateTime.now());

    if (newDate == null) return;

    setState(() => _dateTime = newDate);
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
