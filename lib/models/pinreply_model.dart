import 'dart:convert';

class PinpostReplyModel {


  final String pin_id;
  final String circle_id;
  final String pin_reply_id;
  final String reply_user_id;
  final String pin_reply_text;
  String date;
  final String fname;
  final String lname;
  final String profileImage;
  PinpostReplyModel({
    required this.pin_id,
    required this.circle_id,
    required this.pin_reply_id,
    required this.reply_user_id,
    required this.pin_reply_text,
    required this.date,
    required this.fname,
    required this.lname,
    required this.profileImage,
  });


  PinpostReplyModel copyWith({
    String? pin_id,
    String? circle_id,
    String? pin_reply_id,
    String? reply_user_id,
    String? pin_reply_text,
    String? date,
    String? fname,
    String? lname,
    String? profileImage,
  }) {
    return PinpostReplyModel(
      pin_id: pin_id ?? this.pin_id,
      circle_id: circle_id ?? this.circle_id,
      pin_reply_id: pin_reply_id ?? this.pin_reply_id,
      reply_user_id: reply_user_id ?? this.reply_user_id,
      pin_reply_text: pin_reply_text ?? this.pin_reply_text,
      date: date ?? this.date,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'pin_id': pin_id});
    result.addAll({'circle_id': circle_id});
    result.addAll({'pin_reply_id': pin_reply_id});
    result.addAll({'reply_user_id': reply_user_id});
    result.addAll({'pin_reply_text': pin_reply_text});
    result.addAll({'date': date});
    result.addAll({'fname': fname});
    result.addAll({'lname': lname});
    result.addAll({'profileImage': profileImage});
  
    return result;
  }

  factory PinpostReplyModel.fromMap(Map<String, dynamic> map) {
    return PinpostReplyModel(
      pin_id: map['pin_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      pin_reply_id: map['pin_reply_id'] ?? '',
      reply_user_id: map['reply_user_id'] ?? '',
      pin_reply_text: map['pin_reply_text'] ?? '',
      date: map['date'] ?? '',
      fname: map['fname'] ?? '',
      lname: map['lname'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PinpostReplyModel.fromJson(String source) => PinpostReplyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PinpostReplyModel(pin_id: $pin_id, circle_id: $circle_id, pin_reply_id: $pin_reply_id, reply_user_id: $reply_user_id, pin_reply_text: $pin_reply_text, date: $date, fname: $fname, lname: $lname, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PinpostReplyModel &&
      other.pin_id == pin_id &&
      other.circle_id == circle_id &&
      other.pin_reply_id == pin_reply_id &&
      other.reply_user_id == reply_user_id &&
      other.pin_reply_text == pin_reply_text &&
      other.date == date &&
      other.fname == fname &&
      other.lname == lname &&
      other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return pin_id.hashCode ^
      circle_id.hashCode ^
      pin_reply_id.hashCode ^
      reply_user_id.hashCode ^
      pin_reply_text.hashCode ^
      date.hashCode ^
      fname.hashCode ^
      lname.hashCode ^
      profileImage.hashCode;
  }
}
