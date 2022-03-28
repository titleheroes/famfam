import 'dart:convert';

class MyOrdereModel {
  final String circle_id;
  final String owner_id;
  final String owner_fname;
  final String employee_id;
  final String employee_profile;
  final String employee_fname;
  final String? my_order_id;
  final String my_order_topic;
  final String my_order_desc;
  final String my_order_status;
  MyOrdereModel({
    required this.circle_id,
    required this.owner_id,
    required this.owner_fname,
    required this.employee_id,
    required this.employee_profile,
    required this.employee_fname,
    this.my_order_id,
    required this.my_order_topic,
    required this.my_order_desc,
    required this.my_order_status,
  });

  MyOrdereModel copyWith({
    String? circle_id,
    String? owner_id,
    String? owner_fname,
    String? employee_id,
    String? employee_profile,
    String? employee_fname,
    String? my_order_id,
    String? my_order_topic,
    String? my_order_desc,
    String? my_order_status,
  }) {
    return MyOrdereModel(
      circle_id: circle_id ?? this.circle_id,
      owner_id: owner_id ?? this.owner_id,
      owner_fname: owner_fname ?? this.owner_fname,
      employee_id: employee_id ?? this.employee_id,
      employee_profile: employee_profile ?? this.employee_profile,
      employee_fname: employee_fname ?? this.employee_fname,
      my_order_id: my_order_id ?? this.my_order_id,
      my_order_topic: my_order_topic ?? this.my_order_topic,
      my_order_desc: my_order_desc ?? this.my_order_desc,
      my_order_status: my_order_status ?? this.my_order_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'circle_id': circle_id,
      'owner_id': owner_id,
      'owner_fname': owner_fname,
      'employee_id': employee_id,
      'employee_profile': employee_profile,
      'employee_fname': employee_fname,
      'my_order_id': my_order_id,
      'my_order_topic': my_order_topic,
      'my_order_desc': my_order_desc,
      'my_order_status': my_order_status,
    };
  }

  factory MyOrdereModel.fromMap(Map<String, dynamic> map) {
    return MyOrdereModel(
      circle_id: map['circle_id'] ?? '',
      owner_id: map['owner_id'] ?? '',
      owner_fname: map['owner_fname'] ?? '',
      employee_id: map['employee_id'] ?? '',
      employee_profile: map['employee_profile'] ?? '',
      employee_fname: map['employee_fname'] ?? '',
      my_order_id: map['my_order_id'],
      my_order_topic: map['my_order_topic'] ?? '',
      my_order_desc: map['my_order_desc'] ?? '',
      my_order_status: map['my_order_status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyOrdereModel.fromJson(String source) =>
      MyOrdereModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyOrdereModel(circle_id: $circle_id, owner_id: $owner_id, owner_fname: $owner_fname, employee_id: $employee_id, employee_profile: $employee_profile, employee_fname: $employee_fname, my_order_id: $my_order_id, my_order_topic: $my_order_topic, my_order_desc: $my_order_desc, my_order_status: $my_order_status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyOrdereModel &&
        other.circle_id == circle_id &&
        other.owner_id == owner_id &&
        other.owner_fname == owner_fname &&
        other.employee_id == employee_id &&
        other.employee_profile == employee_profile &&
        other.employee_fname == employee_fname &&
        other.my_order_id == my_order_id &&
        other.my_order_topic == my_order_topic &&
        other.my_order_desc == my_order_desc &&
        other.my_order_status == my_order_status;
  }

  @override
  int get hashCode {
    return circle_id.hashCode ^
        owner_id.hashCode ^
        owner_fname.hashCode ^
        employee_id.hashCode ^
        employee_profile.hashCode ^
        employee_fname.hashCode ^
        my_order_id.hashCode ^
        my_order_topic.hashCode ^
        my_order_desc.hashCode ^
        my_order_status.hashCode;
  }
}
