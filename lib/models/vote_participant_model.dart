import 'dart:convert';

class VoteParticipantModel {
  final String vote_participant_id;
  final String vote_id;
  final String participant_id;
  final String vote_option_id;
  VoteParticipantModel({
    required this.vote_participant_id,
    required this.vote_id,
    required this.participant_id,
    required this.vote_option_id,
  });

  VoteParticipantModel copyWith({
    String? vote_participant_id,
    String? vote_id,
    String? participant_id,
    String? vote_option_id,
  }) {
    return VoteParticipantModel(
      vote_participant_id: vote_participant_id ?? this.vote_participant_id,
      vote_id: vote_id ?? this.vote_id,
      participant_id: participant_id ?? this.participant_id,
      vote_option_id: vote_option_id ?? this.vote_option_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vote_participant_id': vote_participant_id,
      'vote_id': vote_id,
      'participant_id': participant_id,
      'vote_option_id': vote_option_id,
    };
  }

  factory VoteParticipantModel.fromMap(Map<String, dynamic> map) {
    return VoteParticipantModel(
      vote_participant_id: map['vote_participant_id'] ?? '',
      vote_id: map['vote_id'] ?? '',
      participant_id: map['participant_id'] ?? '',
      vote_option_id: map['vote_option_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VoteParticipantModel.fromJson(String source) =>
      VoteParticipantModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VoteParticipantModel(vote_participant_id: $vote_participant_id, vote_id: $vote_id, participant_id: $participant_id, vote_option_id: $vote_option_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoteParticipantModel &&
        other.vote_participant_id == vote_participant_id &&
        other.vote_id == vote_id &&
        other.participant_id == participant_id &&
        other.vote_option_id == vote_option_id;
  }

  @override
  int get hashCode {
    return vote_participant_id.hashCode ^
        vote_id.hashCode ^
        participant_id.hashCode ^
        vote_option_id.hashCode;
  }
}
