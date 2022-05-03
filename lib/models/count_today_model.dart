import 'dart:convert';

class count_today_Model {

  final String id;
  final String user_id;
  final String today_id_do_text;
  final String count;
  count_today_Model({
    required this.id,
    required this.user_id,
    required this.today_id_do_text,
    required this.count,
  });





  count_today_Model copyWith({
    String? id,
    String? user_id,
    String? today_id_do_text,
    String? count,
  }) {
    return count_today_Model(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      today_id_do_text: today_id_do_text ?? this.today_id_do_text,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'user_id': user_id});
    result.addAll({'today_id_do_text': today_id_do_text});
    result.addAll({'count': count});
  
    return result;
  }

  factory count_today_Model.fromMap(Map<String, dynamic> map) {
    return count_today_Model(
      id: map['id'] ?? '',
      user_id: map['user_id'] ?? '',
      today_id_do_text: map['today_id_do_text'] ?? '',
      count: map['count'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory count_today_Model.fromJson(String source) => count_today_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'count_today_Model(id: $id, user_id: $user_id, today_id_do_text: $today_id_do_text, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is count_today_Model &&
      other.id == id &&
      other.user_id == user_id &&
      other.today_id_do_text == today_id_do_text &&
      other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      today_id_do_text.hashCode ^
      count.hashCode;
  }
}
