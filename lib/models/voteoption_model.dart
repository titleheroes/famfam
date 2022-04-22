import 'dart:convert';

class VoteOptionModel {
  final String vote_id;
  final String vote_option_id;
  final String vote_option_name;
  final String vote_option_point;
  VoteOptionModel({
    required this.vote_id,
    required this.vote_option_id,
    required this.vote_option_name,
    required this.vote_option_point,
  });

  VoteOptionModel copyWith({
    String? vote_id,
    String? vote_option_id,
    String? vote_option_name,
    String? vote_option_point,
  }) {
    return VoteOptionModel(
      vote_id: vote_id ?? this.vote_id,
      vote_option_id: vote_option_id ?? this.vote_option_id,
      vote_option_name: vote_option_name ?? this.vote_option_name,
      vote_option_point: vote_option_point ?? this.vote_option_point,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vote_id': vote_id,
      'vote_option_id': vote_option_id,
      'vote_option_name': vote_option_name,
      'vote_option_point': vote_option_point,
    };
  }

  factory VoteOptionModel.fromMap(Map<String, dynamic> map) {
    return VoteOptionModel(
      vote_id: map['vote_id'] ?? '',
      vote_option_id: map['vote_option_id'] ?? '',
      vote_option_name: map['vote_option_name'] ?? '',
      vote_option_point: map['vote_option_point'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VoteOptionModel.fromJson(String source) =>
      VoteOptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VoteOptionModel(vote_id: $vote_id, vote_option_id: $vote_option_id, vote_option_name: $vote_option_name, vote_option_point: $vote_option_point)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoteOptionModel &&
        other.vote_id == vote_id &&
        other.vote_option_id == vote_option_id &&
        other.vote_option_name == vote_option_name &&
        other.vote_option_point == vote_option_point;
  }

  @override
  int get hashCode {
    return vote_id.hashCode ^
        vote_option_id.hashCode ^
        vote_option_name.hashCode ^
        vote_option_point.hashCode;
  }
}
