import 'dart:convert';

class ReplyNumberModel {

    final String pin_id;
    final String circle_id;
    final String author_id;
    final String pin_text;
    final String number_of_reply;
  ReplyNumberModel({
    required this.pin_id,
    required this.circle_id,
    required this.author_id,
    required this.pin_text,
    required this.number_of_reply,
  });


  ReplyNumberModel copyWith({
    String? pin_id,
    String? circle_id,
    String? author_id,
    String? pin_text,
    String? number_of_reply,
  }) {
    return ReplyNumberModel(
      pin_id: pin_id ?? this.pin_id,
      circle_id: circle_id ?? this.circle_id,
      author_id: author_id ?? this.author_id,
      pin_text: pin_text ?? this.pin_text,
      number_of_reply: number_of_reply ?? this.number_of_reply,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'pin_id': pin_id});
    result.addAll({'circle_id': circle_id});
    result.addAll({'author_id': author_id});
    result.addAll({'pin_text': pin_text});
    result.addAll({'number_of_reply': number_of_reply});
  
    return result;
  }

  factory ReplyNumberModel.fromMap(Map<String, dynamic> map) {
    return ReplyNumberModel(
      pin_id: map['pin_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      author_id: map['author_id'] ?? '',
      pin_text: map['pin_text'] ?? '',
      number_of_reply: map['number_of_reply'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReplyNumberModel.fromJson(String source) => ReplyNumberModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReplyNumberModel(pin_id: $pin_id, circle_id: $circle_id, author_id: $author_id, pin_text: $pin_text, number_of_reply: $number_of_reply)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReplyNumberModel &&
      other.pin_id == pin_id &&
      other.circle_id == circle_id &&
      other.author_id == author_id &&
      other.pin_text == pin_text &&
      other.number_of_reply == number_of_reply;
  }

  @override
  int get hashCode {
    return pin_id.hashCode ^
      circle_id.hashCode ^
      author_id.hashCode ^
      pin_text.hashCode ^
      number_of_reply.hashCode;
  }
}
