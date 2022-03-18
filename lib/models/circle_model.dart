import 'dart:convert';

class CircleModel {
  final String? circle_id;
  final String circle_code;
  final String circle_name;
  final String host_id;
  final String member_id;
  CircleModel({
    this.circle_id,
    required this.circle_code,
    required this.circle_name,
    required this.host_id,
    required this.member_id,
  });

  CircleModel copyWith({
    String? circle_id,
    String? circle_code,
    String? circle_name,
    String? host_id,
    String? member_id,
  }) {
    return CircleModel(
      circle_id: circle_id ?? this.circle_id,
      circle_code: circle_code ?? this.circle_code,
      circle_name: circle_name ?? this.circle_name,
      host_id: host_id ?? this.host_id,
      member_id: member_id ?? this.member_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'circle_id': circle_id,
      'circle_code': circle_code,
      'circle_name': circle_name,
      'host_id': host_id,
      'member_id': member_id,
    };
  }

  factory CircleModel.fromMap(Map<String, dynamic> map) {
    return CircleModel(
      circle_id: map['circle_id'],
      circle_code: map['circle_code'] ?? '',
      circle_name: map['circle_name'] ?? '',
      host_id: map['host_id'] ?? '',
      member_id: map['member_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CircleModel.fromJson(String source) =>
      CircleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CircleModel(circle_id: $circle_id, circle_code: $circle_code, circle_name: $circle_name, host_id: $host_id, member_id: $member_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CircleModel &&
        other.circle_id == circle_id &&
        other.circle_code == circle_code &&
        other.circle_name == circle_name &&
        other.host_id == host_id &&
        other.member_id == member_id;
  }

  @override
  int get hashCode {
    return circle_id.hashCode ^
        circle_code.hashCode ^
        circle_name.hashCode ^
        host_id.hashCode ^
        member_id.hashCode;
  }
}
