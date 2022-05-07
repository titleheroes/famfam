import 'dart:convert';

class randomModel {
  final String user_id;
  final String user_profile;
  final String circle_id;
  final String? random_id;
  final String random_topic;
  final String random_final;
  randomModel({
    required this.user_id,
    required this.user_profile,
    required this.circle_id,
    this.random_id,
    required this.random_topic,
    required this.random_final,
  });

  randomModel copyWith({
    String? user_id,
    String? user_profile,
    String? circle_id,
    String? random_id,
    String? random_topic,
    String? random_final,
  }) {
    return randomModel(
      user_id: user_id ?? this.user_id,
      user_profile: user_profile ?? this.user_profile,
      circle_id: circle_id ?? this.circle_id,
      random_id: random_id ?? this.random_id,
      random_topic: random_topic ?? this.random_topic,
      random_final: random_final ?? this.random_final,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'user_profile': user_profile,
      'circle_id': circle_id,
      'random_id': random_id,
      'random_topic': random_topic,
      'random_final': random_final,
    };
  }

  factory randomModel.fromMap(Map<String, dynamic> map) {
    return randomModel(
      user_id: map['user_id'] ?? '',
      user_profile: map['user_profile'] ?? '',
      circle_id: map['circle_id'] ?? '',
      random_id: map['random_id'],
      random_topic: map['random_topic'] ?? '',
      random_final: map['random_final'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory randomModel.fromJson(String source) =>
      randomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'randomModel(user_id: $user_id, user_profile: $user_profile, circle_id: $circle_id, random_id: $random_id, random_topic: $random_topic, random_final: $random_final)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is randomModel &&
        other.user_id == user_id &&
        other.user_profile == user_profile &&
        other.circle_id == circle_id &&
        other.random_id == random_id &&
        other.random_topic == random_topic &&
        other.random_final == random_final;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        user_profile.hashCode ^
        circle_id.hashCode ^
        random_id.hashCode ^
        random_topic.hashCode ^
        random_final.hashCode;
  }
}
