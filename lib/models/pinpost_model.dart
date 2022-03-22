import 'dart:convert';

class PinpostModel {


  final String pin_id;
  final String circle_id;
  final String date;
  final String author_id;
  final String pin_text;
  
  PinpostModel({
    required this.pin_id,
    required this.circle_id,
    required this.date,
    required this.author_id,
    required this.pin_text,
  });



  PinpostModel copyWith({
    String? pin_id,
    String? circle_id,
    String? date,
    String? author_id,
    String? pin_text,
  }) {
    return PinpostModel(
      pin_id: pin_id ?? this.pin_id,
      circle_id: circle_id ?? this.circle_id,
      date: date ?? this.date,
      author_id: author_id ?? this.author_id,
      pin_text: pin_text ?? this.pin_text,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'pin_id': pin_id});
    result.addAll({'circle_id': circle_id});
    result.addAll({'date': date});
    result.addAll({'author_id': author_id});
    result.addAll({'pin_text': pin_text});
  
    return result;
  }

  factory PinpostModel.fromMap(Map<String, dynamic> map) {
    return PinpostModel(
      pin_id: map['pin_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      date: map['date'] ?? '',
      author_id: map['author_id'] ?? '',
      pin_text: map['pin_text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PinpostModel.fromJson(String source) => PinpostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PinpostModel(pin_id: $pin_id, circle_id: $circle_id, date: $date, author_id: $author_id, pin_text: $pin_text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PinpostModel &&
      other.pin_id == pin_id &&
      other.circle_id == circle_id &&
      other.date == date &&
      other.author_id == author_id &&
      other.pin_text == pin_text;
  }

  @override
  int get hashCode {
    return pin_id.hashCode ^
      circle_id.hashCode ^
      date.hashCode ^
      author_id.hashCode ^
      pin_text.hashCode;
  }
}
