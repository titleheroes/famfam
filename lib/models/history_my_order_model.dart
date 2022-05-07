import 'dart:convert';

class HistoryMyOrderModel {
  final String history_my_order_id;
  final String history_my_order_uid;
  final String owner_fname;
  final String my_order_topic;
  final String my_order_status;
  HistoryMyOrderModel({
    required this.history_my_order_id,
    required this.history_my_order_uid,
    required this.owner_fname,
    required this.my_order_topic,
    required this.my_order_status,
  });

  HistoryMyOrderModel copyWith({
    String? history_my_order_id,
    String? history_my_order_uid,
    String? owner_fname,
    String? my_order_topic,
    String? my_order_status,
  }) {
    return HistoryMyOrderModel(
      history_my_order_id: history_my_order_id ?? this.history_my_order_id,
      history_my_order_uid: history_my_order_uid ?? this.history_my_order_uid,
      owner_fname: owner_fname ?? this.owner_fname,
      my_order_topic: my_order_topic ?? this.my_order_topic,
      my_order_status: my_order_status ?? this.my_order_status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'history_my_order_id': history_my_order_id,
      'history_my_order_uid': history_my_order_uid,
      'owner_fname': owner_fname,
      'my_order_topic': my_order_topic,
      'my_order_status': my_order_status,
    };
  }

  factory HistoryMyOrderModel.fromMap(Map<String, dynamic> map) {
    return HistoryMyOrderModel(
      history_my_order_id: map['history_my_order_id'] ?? '',
      history_my_order_uid: map['history_my_order_uid'] ?? '',
      owner_fname: map['owner_fname'] ?? '',
      my_order_topic: map['my_order_topic'] ?? '',
      my_order_status: map['my_order_status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryMyOrderModel.fromJson(String source) =>
      HistoryMyOrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryMyOrderModel(history_my_order_id: $history_my_order_id, history_my_order_uid: $history_my_order_uid, owner_fname: $owner_fname, my_order_topic: $my_order_topic, my_order_status: $my_order_status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryMyOrderModel &&
        other.history_my_order_id == history_my_order_id &&
        other.history_my_order_uid == history_my_order_uid &&
        other.owner_fname == owner_fname &&
        other.my_order_topic == my_order_topic &&
        other.my_order_status == my_order_status;
  }

  @override
  int get hashCode {
    return history_my_order_id.hashCode ^
        history_my_order_uid.hashCode ^
        owner_fname.hashCode ^
        my_order_topic.hashCode ^
        my_order_status.hashCode;
  }
}
