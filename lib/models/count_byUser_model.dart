import 'dart:convert';

class count_byUser_Model {

    final String  id;
    final String  user_id;
    final String? today_i_do_text;
    final String  count;
  count_byUser_Model({
    required this.id,
    required this.user_id,
    this.today_i_do_text,
    required this.count,
  });


  count_byUser_Model copyWith({
    String? id,
    String? user_id,
    String? today_i_do_text,
    String? count,
  }) {
    return count_byUser_Model(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      today_i_do_text: today_i_do_text ?? this.today_i_do_text,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'user_id': user_id});
    if(today_i_do_text != null){
      result.addAll({'today_i_do_text': today_i_do_text});
    }
    result.addAll({'count': count});
  
    return result;
  }

  factory count_byUser_Model.fromMap(Map<String, dynamic> map) {
    return count_byUser_Model(
      id: map['id'] ?? '',
      user_id: map['user_id'] ?? '',
      today_i_do_text: map['today_i_do_text'],
      count: map['count'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory count_byUser_Model.fromJson(String source) => count_byUser_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'count_byUser_Model(id: $id, user_id: $user_id, today_i_do_text: $today_i_do_text, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is count_byUser_Model &&
      other.id == id &&
      other.user_id == user_id &&
      other.today_i_do_text == today_i_do_text &&
      other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      today_i_do_text.hashCode ^
      count.hashCode;
  }
}
