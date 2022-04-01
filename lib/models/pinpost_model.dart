import 'dart:convert';

class PinpostModel {


  final String pin_id;
  final String circle_id;
  final String author_id;
  String date;
  final String pin_text;
  final String fname;
  final String lname;
  final String profileImage;
  final String number_of_reply;
  PinpostModel({
    required this.pin_id,
    required this.circle_id,
    required this.author_id,
    required this.date,
    required this.pin_text,
    required this.fname,
    required this.lname,
    required this.profileImage,
    required this.number_of_reply,
  });
  
  

  PinpostModel copyWith({
    String? pin_id,
    String? circle_id,
    String? author_id,
    String? date,
    String? pin_text,
    String? fname,
    String? lname,
    String? profileImage,
    String? number_of_reply,
  }) {
    return PinpostModel(
      pin_id: pin_id ?? this.pin_id,
      circle_id: circle_id ?? this.circle_id,
      author_id: author_id ?? this.author_id,
      date: date ?? this.date,
      pin_text: pin_text ?? this.pin_text,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      profileImage: profileImage ?? this.profileImage,
      number_of_reply: number_of_reply ?? this.number_of_reply,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'pin_id': pin_id});
    result.addAll({'circle_id': circle_id});
    result.addAll({'author_id': author_id});
    result.addAll({'date': date});
    result.addAll({'pin_text': pin_text});
    result.addAll({'fname': fname});
    result.addAll({'lname': lname});
    result.addAll({'profileImage': profileImage});
    result.addAll({'number_of_reply': number_of_reply});
  
    return result;
  }

  factory PinpostModel.fromMap(Map<String, dynamic> map) {
    return PinpostModel(
      pin_id: map['pin_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      author_id: map['author_id'] ?? '',
      date: map['date'] ?? '',
      pin_text: map['pin_text'] ?? '',
      fname: map['fname'] ?? '',
      lname: map['lname'] ?? '',
      profileImage: map['profileImage'] ?? '',
      number_of_reply: map['number_of_reply'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PinpostModel.fromJson(String source) => PinpostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PinpostModel(pin_id: $pin_id, circle_id: $circle_id, author_id: $author_id, date: $date, pin_text: $pin_text, fname: $fname, lname: $lname, profileImage: $profileImage, number_of_reply: $number_of_reply)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PinpostModel &&
      other.pin_id == pin_id &&
      other.circle_id == circle_id &&
      other.author_id == author_id &&
      other.date == date &&
      other.pin_text == pin_text &&
      other.fname == fname &&
      other.lname == lname &&
      other.profileImage == profileImage &&
      other.number_of_reply == number_of_reply;
  }

  @override
  int get hashCode {
    return pin_id.hashCode ^
      circle_id.hashCode ^
      author_id.hashCode ^
      date.hashCode ^
      pin_text.hashCode ^
      fname.hashCode ^
      lname.hashCode ^
      profileImage.hashCode ^
      number_of_reply.hashCode;
  }
  }
 