import 'dart:convert';

class PinpostModel {


  final String pin_id;
  final String circle_id;
  final String date;
  final String author_id;
  final String pin_text;
  final String id;
  final String uid;
  final String profileImage;
  final String fname;
  final String lname;
  final String phone;
  final String birth;
  final String address;
  final String personalID;
  final String jobs;
  PinpostModel({
    required this.pin_id,
    required this.circle_id,
    required this.date,
    required this.author_id,
    required this.pin_text,
    required this.id,
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
  

  PinpostModel copyWith({
    String? pin_id,
    String? circle_id,
    String? date,
    String? author_id,
    String? pin_text,
    String? id,
    String? uid,
    String? profileImage,
    String? fname,
    String? lname,
    String? phone,
    String? birth,
    String? address,
    String? personalID,
    String? jobs,
  }) {
    return PinpostModel(
      pin_id: pin_id ?? this.pin_id,
      circle_id: circle_id ?? this.circle_id,
      date: date ?? this.date,
      author_id: author_id ?? this.author_id,
      pin_text: pin_text ?? this.pin_text,
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
    final result = <String, dynamic>{};
  
    result.addAll({'pin_id': pin_id});
    result.addAll({'circle_id': circle_id});
    result.addAll({'date': date});
    result.addAll({'author_id': author_id});
    result.addAll({'pin_text': pin_text});
    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'profileImage': profileImage});
    result.addAll({'fname': fname});
    result.addAll({'lname': lname});
    result.addAll({'phone': phone});
    result.addAll({'birth': birth});
    result.addAll({'address': address});
    result.addAll({'personalID': personalID});
    result.addAll({'jobs': jobs});
  
    return result;
  }

  factory PinpostModel.fromMap(Map<String, dynamic> map) {
    return PinpostModel(
      pin_id: map['pin_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      date: map['date'] ?? '',
      author_id: map['author_id'] ?? '',
      pin_text: map['pin_text'] ?? '',
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      profileImage: map['profileImage'] ?? '',
      fname: map['fname'] ?? '',
      lname: map['lname'] ?? '',
      phone: map['phone'] ?? '',
      birth: map['birth'] ?? '',
      address: map['address'] ?? '',
      personalID: map['personalID'] ?? '',
      jobs: map['jobs'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PinpostModel.fromJson(String source) => PinpostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PinpostModel(pin_id: $pin_id, circle_id: $circle_id, date: $date, author_id: $author_id, pin_text: $pin_text, id: $id, uid: $uid, profileImage: $profileImage, fname: $fname, lname: $lname, phone: $phone, birth: $birth, address: $address, personalID: $personalID, jobs: $jobs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PinpostModel &&
      other.pin_id == pin_id &&
      other.circle_id == circle_id &&
      other.date == date &&
      other.author_id == author_id &&
      other.pin_text == pin_text &&
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
    return pin_id.hashCode ^
      circle_id.hashCode ^
      date.hashCode ^
      author_id.hashCode ^
      pin_text.hashCode ^
      id.hashCode ^
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


  