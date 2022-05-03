import 'dart:convert';

class HistoryForUserModel {
  final String history_for_user_id;
  final String user_id;
  final String circle_id;
  final String history_status;
  HistoryForUserModel({
    required this.history_for_user_id,
    required this.user_id,
    required this.circle_id,
    required this.history_status,
  });

  HistoryForUserModel copyWith({
    String? history_for_user_id,
    String? user_id,
    String? circle_id,
    String? history_status,
  }) {
    return HistoryForUserModel(
      history_for_user_id: history_for_user_id ?? this.history_for_user_id,
      user_id: user_id ?? this.user_id,
      circle_id: circle_id ?? this.circle_id,
      history_status: history_status ?? this.history_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'history_for_user_id': history_for_user_id,
      'user_id': user_id,
      'circle_id': circle_id,
      'history_status': history_status,
    };
  }

  factory HistoryForUserModel.fromMap(Map<String, dynamic> map) {
    return HistoryForUserModel(
      history_for_user_id: map['history_for_user_id'] ?? '',
      user_id: map['user_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
      history_status: map['history_status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryForUserModel.fromJson(String source) =>
      HistoryForUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryForUserModel(history_for_user_id: $history_for_user_id, user_id: $user_id, circle_id: $circle_id, history_status: $history_status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryForUserModel &&
        other.history_for_user_id == history_for_user_id &&
        other.user_id == user_id &&
        other.circle_id == circle_id &&
        other.history_status == history_status;
  }

  @override
  int get hashCode {
    return history_for_user_id.hashCode ^
        user_id.hashCode ^
        circle_id.hashCode ^
        history_status.hashCode;
  }
}
