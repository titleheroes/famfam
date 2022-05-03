import 'dart:convert';

class HistoryPinPostModel {
  final String history_pinpost_id;
  final String history_pinpost_uid;
  final String author_name;
  final String history_isreply;
  HistoryPinPostModel({
    required this.history_pinpost_id,
    required this.history_pinpost_uid,
    required this.author_name,
    required this.history_isreply,
  });

  HistoryPinPostModel copyWith({
    String? history_pinpost_id,
    String? history_pinpost_uid,
    String? author_name,
    String? history_isreply,
  }) {
    return HistoryPinPostModel(
      history_pinpost_id: history_pinpost_id ?? this.history_pinpost_id,
      history_pinpost_uid: history_pinpost_uid ?? this.history_pinpost_uid,
      author_name: author_name ?? this.author_name,
      history_isreply: history_isreply ?? this.history_isreply,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'history_pinpost_id': history_pinpost_id,
      'history_pinpost_uid': history_pinpost_uid,
      'author_name': author_name,
      'history_isreply': history_isreply,
    };
  }

  factory HistoryPinPostModel.fromMap(Map<String, dynamic> map) {
    return HistoryPinPostModel(
      history_pinpost_id: map['history_pinpost_id'] ?? '',
      history_pinpost_uid: map['history_pinpost_uid'] ?? '',
      author_name: map['author_name'] ?? '',
      history_isreply: map['history_isreply'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryPinPostModel.fromJson(String source) =>
      HistoryPinPostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryPinPostModel(history_pinpost_id: $history_pinpost_id, history_pinpost_uid: $history_pinpost_uid, author_name: $author_name, history_isreply: $history_isreply)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryPinPostModel &&
        other.history_pinpost_id == history_pinpost_id &&
        other.history_pinpost_uid == history_pinpost_uid &&
        other.author_name == author_name &&
        other.history_isreply == history_isreply;
  }

  @override
  int get hashCode {
    return history_pinpost_id.hashCode ^
        history_pinpost_uid.hashCode ^
        author_name.hashCode ^
        history_isreply.hashCode;
  }
}
