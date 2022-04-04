import 'dart:convert';

class list_today_Model {
  final String? id;
  final String user_id;
  final String list_to_do;
  list_today_Model({
    this.id,
    required this.user_id,
    required this.list_to_do,
  });
  list_today_Model copyWith({
    String? id,
    String? user_id,
    String? list_to_do,
  }) {
    return list_today_Model(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      list_to_do: list_to_do ?? this.list_to_do,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'list_to_do': list_to_do,
    };
  }

  factory list_today_Model.fromMap(Map<String, dynamic> map) {
    return list_today_Model(
      id: map['id'],
      user_id: map['user_id'] ?? '',
      list_to_do: map['list_to_do'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory list_today_Model.fromJson(String source) =>
      list_today_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, user_id: $user_id, list_to_do: $list_to_do';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is list_today_Model &&
        other.id == id &&
        other.user_id == user_id &&
        other.list_to_do == list_to_do;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user_id.hashCode ^ list_to_do.hashCode;
  }
}
