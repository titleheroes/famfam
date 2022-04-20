import 'dart:convert';

class VoteModel {
  final String host_id;
  final String host_profile;
  final String participant_id;
  final String circle_id;
  final String vote_id;
  final String vote_uid;
  final String vote_topic;
  final String vote_final;
  VoteModel({
    required this.host_id,
    required this.host_profile,
    required this.participant_id,
    required this.circle_id,
    required this.vote_id,
    required this.vote_uid,
    required this.vote_topic,
    required this.vote_final,
  });

  VoteModel copyWith({
    String? host_id,
    String? host_profile,
    String? participant_id,
    String? circle_id,
    String? vote_id,
    String? vote_uid,
    String? vote_topic,
    String? vote_final,
  }) {
    return VoteModel(
      host_id: host_id ?? this.host_id,
      host_profile: host_profile ?? this.host_profile,
      participant_id: participant_id ?? this.participant_id,
      circle_id: circle_id ?? this.circle_id,
      vote_id: vote_id ?? this.vote_id,
      vote_uid: vote_uid ?? this.vote_uid,
      vote_topic: vote_topic ?? this.vote_topic,
      vote_final: vote_final ?? this.vote_final,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'host_id': host_id,
      'host_profile': host_profile,
      'participant_id': participant_id,
      'circle_id': circle_id,
      'vote_id': vote_id,
      'vote_uid': vote_uid,
      'vote_topic': vote_topic,
      'vote_final': vote_final,
    };
  }

  factory VoteModel.fromMap(Map<String, dynamic> map) {
    return VoteModel(
      host_id: map['host_id'] ?? '',
      host_profile: map['host_profile'] ?? '',
      participant_id: map['participant_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      vote_id: map['vote_id'] ?? '',
      vote_uid: map['vote_uid'] ?? '',
      vote_topic: map['vote_topic'] ?? '',
      vote_final: map['vote_final'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VoteModel.fromJson(String source) =>
      VoteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VoteModel(host_id: $host_id, host_profile: $host_profile, participant_id: $participant_id, circle_id: $circle_id, vote_id: $vote_id, vote_uid: $vote_uid, vote_topic: $vote_topic, vote_final: $vote_final)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoteModel &&
        other.host_id == host_id &&
        other.host_profile == host_profile &&
        other.participant_id == participant_id &&
        other.circle_id == circle_id &&
        other.vote_id == vote_id &&
        other.vote_uid == vote_uid &&
        other.vote_topic == vote_topic &&
        other.vote_final == vote_final;
  }

  @override
  int get hashCode {
    return host_id.hashCode ^
        host_profile.hashCode ^
        participant_id.hashCode ^
        circle_id.hashCode ^
        vote_id.hashCode ^
        vote_uid.hashCode ^
        vote_topic.hashCode ^
        vote_final.hashCode;
  }
}
