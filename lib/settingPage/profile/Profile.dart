import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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
import 'package:famfam/widgets/circle_loader.dart';

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

  DateTime setup = DateTime.now();

  String profile =
      'https://firebasestorage.googleapis.com/v0/b/famfam-c881b.appspot.com/o/userProfile%2FcircleOnbg.png?alt=media&token=80bc8cea-30d6-41d7-8896-c86c021e059e';
  String fname = 'Loading...';
  String lname = 'Loading...';
  String userID = 'Loading...';
  String birth = 'Loading...';
  String personalID = 'Loading...';
  String phone = 'Loading...';
  String address = 'Loading...';
  String jobs = 'Loading...';
  bool profileload = true;

  @override
  void initState() {
    super.initState();
    pullUserSQLID().then((value) {
      profile = userModels[0].profileImage;
      fname = userModels[0].fname;
      lname = userModels[0].lname;
      userID = userModels[0].uid;
      setup = DateTime.parse(userModels[0].birth);
      birth = DateFormat('dd-MM-yyyy').format(setup);
      personalID = userModels[0].personalID;
      phone = userModels[0].phone;
      address = userModels[0].address;
      jobs = userModels[0].jobs;
    }).then((value) => profileload = false);
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
        body: profileload
            ? CircleLoader()
            : Container(
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
                                  bottomRight: Radius.circular(50),
                                ),
                              ),
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
                                  : FileImage(
                                      File(_imageFile!.path),
                                    ),
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
                                        (states) => Colors.white),
                              ),
                              onPressed: () {
                                String profileImage;
                                profileload = true;
                                TakePhoto(ImageSource.gallery).then((value) {
                                  uploadPictureToStorage()
                                      .whenComplete(() async {
                                    if (urlImage == null) {
                                      setState(() {
                                        profileload = false;
                                      });
                                      return;
                                    } else {
                                      setState(() {
                                        profileload = true;
                                      });
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
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${fname} ${lname}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Builder(builder: (context) {
                              if (widget.profileUser == 1) {
                                return IconButton(
                                  icon: SvgPicture.asset(
                                      "assets/icons/pencil.svg"),
                                  onPressed: () async {
                                    editUserName(context, userModels[0].id!,
                                        "Name & Surname", fname, lname);
                                  },
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                        Text(
                          'ID: ' + '$userID',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        headtoppic("Birthdate", birth, 'birth'),
                        headtoppic("Personal ID", personalID, 'personalID'),
                        headtoppic("Phone number", phone, 'phone'),
                        headtoppic("Address", address, 'address'),
                        headtoppic("Jobs", jobs, 'jobs'),
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

  Widget headtoppic(String Head, String Info, String attribute) {
    return Container(
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
          Builder(builder: (context) {
            if (widget.profileUser == 1) {
              return ElevatedButton(
                onPressed: () {
                  if (Head == 'Birthdate') {
                    editUserBirth(
                        context, userModels[0].id!, Head, Info, attribute);
                  } else {
                    editUserInfo(
                        context, userModels[0].id!, Head, Info, attribute);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 160,
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
                  ],
                ),
              );
            } else {
              return Container(
                child: Text(
                  Info,
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                ),
              );
            }
          }),
          Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ),
    );
  }

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

Future editUserName(BuildContext context, String id, String Head, String _fname,
        String _lname) =>
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            TextEditingController fnameController = TextEditingController();
            TextEditingController lnameController = TextEditingController();
            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Text(
                              'Editing ${Head}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Positioned(
                              right: 0,
                              top: -6,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 15),
                      // Text(
                      //   'Circle Name :',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(49, 204, 204, 204),
                          border: Border.all(
                            color: Color(0xFFF9EE6D),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: new InputDecoration.collapsed(
                                        hintText: "${_fname}"),
                                    controller: fnameController,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: TextField(
                                    decoration: new InputDecoration.collapsed(
                                        hintText: "${_lname}"),
                                    controller: lnameController,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.864,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFF9EE6D),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            if (fnameController.text == '' &&
                                lnameController.text == '') {
                              Fluttertoast.showToast(
                                  msg: "Please insert your new ${Head} first.",
                                  gravity: ToastGravity.BOTTOM);
                            } else if (fnameController.text != '' &&
                                lnameController.text == '') {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: const Text(
                                        'Are you sure to edit this change ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          // String? id = id;
                                          // String? attribute = attribute;
                                          String? fname = fnameController.text;
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          String editUserInfo =
                                              '${MyConstant.domain}/famfam/editFnamefromUserID.php?isAdd=true&id=$id&fname=$fname';

                                          await Dio()
                                              .get(editUserInfo)
                                              .then((value) async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(
                                                  userID: FirebaseAuth
                                                      .instance.currentUser!.uid
                                                      .toString(),
                                                  circle_id: preferences
                                                      .getString('circle_id'),
                                                  profileUser: 1,
                                                  profileMem: 0,
                                                  profileOwner: 0,
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('Confirm'),
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                      )
                                    ],
                                  );
                                },
                              );
                            } else if (fnameController.text == '' &&
                                lnameController.text != '') {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: const Text(
                                        'Are you sure to edit this change ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          // String? id = id;
                                          // String? attribute = attribute;
                                          String? lname = lnameController.text;
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          String editUserInfo =
                                              '${MyConstant.domain}/famfam/editLnamefromUserID.php?isAdd=true&id=$id&lname=$lname';

                                          await Dio()
                                              .get(editUserInfo)
                                              .then((value) async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(
                                                  userID: FirebaseAuth
                                                      .instance.currentUser!.uid
                                                      .toString(),
                                                  circle_id: preferences
                                                      .getString('circle_id'),
                                                  profileUser: 1,
                                                  profileMem: 0,
                                                  profileOwner: 0,
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('Confirm'),
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: const Text(
                                        'Are you sure to edit this change ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          // String? id = id;
                                          // String? attribute = attribute;
                                          String? fname = fnameController.text;
                                          String? lname = lnameController.text;
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          String editUserInfo =
                                              '${MyConstant.domain}/famfam/editFnameLnamefromUserID.php?isAdd=true&id=$id&fname=$fname&lname=$lname';

                                          await Dio()
                                              .get(editUserInfo)
                                              .then((value) async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(
                                                  userID: FirebaseAuth
                                                      .instance.currentUser!.uid
                                                      .toString(),
                                                  circle_id: preferences
                                                      .getString('circle_id'),
                                                  profileUser: 1,
                                                  profileMem: 0,
                                                  profileOwner: 0,
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('Confirm'),
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });

Future editUserBirth(BuildContext context, String id, String Head, String Info,
        String attribute) =>
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            TextEditingController detailController = TextEditingController();

            DateTime? _birth;
            String _dateTime = 'Select day';

            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Text(
                              'Editing ${Head}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Positioned(
                              right: 0,
                              top: -6,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 15),
                      // Text(
                      //   'Circle Name :',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(49, 204, 204, 204),
                          border: Border.all(
                            color: Color(0xFFF9EE6D),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                          ),
                        ),
                        child: StatefulBuilder(builder: (context, setState) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              child: Text(
                                _dateTime,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 252, 192, 14),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                      bottomLeft: const Radius.circular(20.0),
                                      bottomRight: const Radius.circular(20.0),
                                    ),
                                    side: BorderSide(
                                      color: Color(0xFFF9EE6D),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final initialDate = DateTime.now();
                                final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(1940),
                                    lastDate: DateTime.now());

                                if (newDate == null) return;

                                setState(
                                  () {
                                    _dateTime = DateFormat('dd-MM-yyyy')
                                        .format(newDate);
                                    _birth = newDate;
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.864,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFF9EE6D),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            if (_dateTime == 'Select day') {
                              Fluttertoast.showToast(
                                  msg: "Please select your new ${Head} first.",
                                  gravity: ToastGravity.BOTTOM);
                            } else {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: const Text(
                                        'Are you sure to edit this change ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          // String? id = id;
                                          // String? attribute = attribute;
                                          Info = _birth.toString();
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          String editUserInfo =
                                              '${MyConstant.domain}/famfam/editUserInfofromUserID.php?isAdd=true&id=$id&attribute=$attribute&Info=$Info';

                                          await Dio()
                                              .get(editUserInfo)
                                              .then((value) async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(
                                                  userID: FirebaseAuth
                                                      .instance.currentUser!.uid
                                                      .toString(),
                                                  circle_id: preferences
                                                      .getString('circle_id'),
                                                  profileUser: 1,
                                                  profileMem: 0,
                                                  profileOwner: 0,
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('Confirm'),
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

Future editUserInfo(BuildContext context, String id, String Head, String Info,
        String attribute) =>
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            TextEditingController detailController = TextEditingController();
            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Text(
                              'Editing ${Head}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Positioned(
                              right: 0,
                              top: -6,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 15),
                      // Text(
                      //   'Circle Name :',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(49, 204, 204, 204),
                          border: Border.all(
                            color: Color(0xFFF9EE6D),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TextField(
                              decoration: new InputDecoration.collapsed(
                                  hintText: "${Info}"),
                              controller: detailController,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.864,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFF9EE6D),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            if (detailController.text == '') {
                              Fluttertoast.showToast(
                                  msg: "Please insert your new ${Head} first.",
                                  gravity: ToastGravity.BOTTOM);
                            } else {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: const Text(
                                        'Are you sure to edit this change ?'),
                                    actions: [
                                      // The "Yes" button
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        isDefaultAction: false,
                                        isDestructiveAction: false,
                                      ),
                                      // The "No" button
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          // String? id = id;
                                          // String? attribute = attribute;
                                          Info = detailController.text;
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          String editUserInfo =
                                              '${MyConstant.domain}/famfam/editUserInfofromUserID.php?isAdd=true&id=$id&attribute=$attribute&Info=$Info';

                                          await Dio()
                                              .get(editUserInfo)
                                              .then((value) async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(
                                                  userID: FirebaseAuth
                                                      .instance.currentUser!.uid
                                                      .toString(),
                                                  circle_id: preferences
                                                      .getString('circle_id'),
                                                  profileUser: 1,
                                                  profileMem: 0,
                                                  profileOwner: 0,
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('Confirm'),
                                        isDefaultAction: true,
                                        isDestructiveAction: true,
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
