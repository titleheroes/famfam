import 'dart:convert';

import 'package:famfam/Homepage/date.dart';

class UserModel {
  final int? id;
  final String uid;
  final String profileImage;
  final String fname;
  final String lname;
  final String phone;
  final DateTime birth;
  final String address;
  final String personalID;
  final String jobs;
  UserModel({
    this.id,
    required this.uid,
    required this.profileImage,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.birth,
    required this.address,
    required this.personalID,
    required this.jobs,
  });

  UserModel copyWith({
    int? id,
    String? uid,
    String? profileImage,
    String? fname,
    String? lname,
    String? phone,
    DateTime? birth,
    String? address,
    String? personalID,
    String? jobs,
  }) {
    return UserModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      profileImage: profileImage ?? this.profileImage,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      birth: birth ?? this.birth,
      address: address ?? this.address,
      personalID: personalID ?? this.personalID,
      jobs: jobs ?? this.jobs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'profileImage': profileImage,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'birth': birth.millisecondsSinceEpoch,
      'address': address,
      'personalID': personalID,
      'jobs': jobs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
      profileImage: map['profileImage'] ?? '',
      fname: map['fname'] ?? '',
      lname: map['lname'] ?? '',
      phone: map['phone'] ?? '',
      birth: DateTime.fromMillisecondsSinceEpoch(map['birth']),
      address: map['address'] ?? '',
      personalID: map['personalID'] ?? '',
      jobs: map['jobs'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, uid: $uid, profileImage: $profileImage, fname: $fname, lname: $lname, phone: $phone, birth: $birth, address: $address, personalID: $personalID, jobs: $jobs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.uid == uid &&
        other.profileImage == profileImage &&
        other.fname == fname &&
        other.lname == lname &&
        other.phone == phone &&
        other.birth == birth &&
        other.address == address &&
        other.personalID == personalID &&
        other.jobs == jobs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        profileImage.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        phone.hashCode ^
        birth.hashCode ^
        address.hashCode ^
        personalID.hashCode ^
        jobs.hashCode;
  }
}
