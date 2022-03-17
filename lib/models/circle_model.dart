import 'dart:convert';

class CircleModel {
  final String? circle_id;
  final String circle_code;
  final String circle_name;
  final String user_id;
  CircleModel({
    this.circle_id,
    required this.circle_code,
    required this.circle_name,
    required this.user_id,
  });

  CircleModel copyWith({
    String? circle_id,
    String? circle_code,
    String? circle_name,
    String? user_id,
  }) {
    return CircleModel(
      circle_id: circle_id ?? this.circle_id,
      circle_code: circle_code ?? this.circle_code,
      circle_name: circle_name ?? this.circle_name,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'circle_id': circle_id,
      'circle_code': circle_code,
      'circle_name': circle_name,
      'user_id': user_id,
    };
  }

  factory CircleModel.fromMap(Map<String, dynamic> map) {
    return CircleModel(
      circle_id: map['circle_id'],
      circle_code: map['circle_code'] ?? '',
      circle_name: map['circle_name'] ?? '',
      user_id: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleModel.fromJson(String source) =>
      CircleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CircleModel(circle_id: $circle_id, circle_code: $circle_code, circle_name: $circle_name, user_id: $user_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CircleModel &&
        other.circle_id == circle_id &&
        other.circle_code == circle_code &&
        other.circle_name == circle_name &&
        other.user_id == user_id;
  }

  @override
  int get hashCode {
    return circle_id.hashCode ^
        circle_code.hashCode ^
        circle_name.hashCode ^
        user_id.hashCode;
  }
}
