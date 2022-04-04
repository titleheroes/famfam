import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:famfam/models/user_model.dart';
import 'package:famfam/services/my_constant.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final String? userID;
  final String? circle_id;
  final int? profileUser;
  final int? profileMem;
  final int? profileOwner;
  Profile({
    Key? key,
    @required this.userID,
    @required this.circle_id,
    @required this.profileMem,
    @required this.profileOwner,
    @required this.profileUser,
  }) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<UserModel> userModels = [];

  String? urlImage;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String profile =
      'https://firebasestorage.googleapis.com/v0/b/famfam-c881b.appspot.com/o/userProfile%2FcircleOnbg.png?alt=media&token=80bc8cea-30d6-41d7-8896-c86c021e059e';
  String name = 'Loading...';
  String userID = 'Loading...';
  String birthday = 'Loading...';
  String PersonId = 'Loading...';
  String phone = 'Loading...';
  String address = 'Loading...';
  String job = 'Loading...';

  @override
  void initState() {
    super.initState();
    pullUserSQLID().then((value) {
      profile = userModels[0].profileImage;
      name = '${userModels[0].fname} ${userModels[0].lname}';
      userID = userModels[0].uid;
      birthday = userModels[0].birth;
      PersonId = userModels[0].personalID;
      phone = userModels[0].phone;
      address = userModels[0].address;
      job = userModels[0].jobs;
    });
  }

  Future<Null> pullUserSQLID() async {
    final String getUID = widget.userID!;
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

  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Profile",
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
              if (widget.profileOwner == 1 || widget.profileMem == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    print(widget.circle_id);
                    return memberPage(
                      circle_id: widget.circle_id,
                    );
                  }),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => settingPage(),
                  ),
                );
              }
            },
          ),
          elevation: 0,
          backgroundColor: Color(0xFFF6E5C7),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 9,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 9,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xFFF6E5C7),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Container(
                      width: 200,
                      height: 200,
                      // child: Image.network(profile),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 8,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: _imageFile == null
                            ? NetworkImage(profile) as ImageProvider
                            : FileImage(File(_imageFile!.path)),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 150,
                      child: Container(
                          width: 60,
                          height: 60,
                          child: ElevatedButton(
                            child: Icon(
                              Icons.autorenew_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all(CircleBorder()),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.white)),
                            onPressed: () {
                              String profileImage;
                              TakePhoto(ImageSource.gallery).then((value) {
                                uploadPictureToStorage().whenComplete(() async {
                                  if (urlImage == null) {
                                    return;
                                  } else {
                                    String uid = userModels[0].uid;
                                    profileImage =
                                        Uri.encodeComponent(urlImage!);
                                    String apiInsertUser =
                                        '${MyConstant.domain}/famfam/updateProfileUserWhereUID.php?isAdd=true&uid=$uid&profileImage=$profileImage';
                                    await Dio()
                                        .get(apiInsertUser)
                                        .then((value) async {
                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Profile(
                                            userID: widget.userID,
                                            circle_id: widget.circle_id,
                                            profileUser: widget.profileUser,
                                            profileMem: widget.profileMem,
                                            profileOwner: widget.profileOwner,
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                });
                              });
                            },
                          )))
                ],
              ),
              Column(
                children: [
                  Text(name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  Text(
                    'ID: ' + '$userID',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  headtoppic("Birthdate", birthday),
                  headtoppic("Personal ID", PersonId),
                  headtoppic("Phone number", phone),
                  headtoppic("Address", address),
                  headtoppic("Job", job),
                ],
              ),
              CheckUser(widget.profileUser!, widget.profileMem!,
                  widget.profileOwner!),
            ],
          ),
        ),
      ),
    );
  }

  Widget headtoppic(String Head, String Info) => Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 30)),
          Text(Head,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          Spacer(),
          Container(
            child: Text(
              Info,
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              maxLines: 3,
              overflow: TextOverflow.clip,
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey[500],
            size: 30,
          ),
          Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ));
  Widget CheckUser(
    int profileUser,
    int profileMem,
    int profileOwner,
  ) =>
      Container(
          child: profileMem == 1
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 50),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Center(
                      child: Text(
                    'This is member',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFA3A3),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                )
              : profileOwner == 1
                  ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 50),
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Center(
                          child: Text('This is Owner',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFA3A3),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    )
                  : Container());

  Future<void> TakePhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = PickedFile;
    });
  }

  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(10000);
    var imageFile;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    if (_imageFile == null) {
      return;
    } else {
      imageFile = File(_imageFile!.path);
      print(_imageFile!.path);
    }

    Reference storageReference = firebaseStorage
        .ref()
        .child('userProfile/' + userModels[0].fname + i.toString());

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
}
