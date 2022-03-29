import 'dart:convert';

class ticktick_Model {
  final String? tick_id;
  final String tick_uid;
  final String circle_id;
  final String user_id;
  final String tick_topic;
  final String ticklist_list;
  ticktick_Model(
      {this.tick_id,
      required this.tick_uid,
      required this.circle_id,
      required this.user_id,
      required this.tick_topic,
      required this.ticklist_list});
  ticktick_Model copyWith({
    String? tick_id,
    String? tick_uid,
    String? circle_id,
    String? user_id,
    String? tick_topic,
    String? ticklist_list,
  }) {
    return ticktick_Model(
      tick_id: tick_id ?? this.tick_id,
      tick_uid: tick_uid ?? this.tick_uid,
      circle_id: circle_id ?? this.circle_id,
      user_id: tick_id ?? this.user_id,
      tick_topic: tick_uid ?? this.tick_topic,
      ticklist_list: circle_id ?? this.ticklist_list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tick_id': tick_id,
      'tick_uid': tick_uid,
      'circle_id': circle_id,
      'user_id': user_id,
      'tick_topic': tick_topic,
      'ticklist_list': ticklist_list,
    };
  }

  factory ticktick_Model.fromMap(Map<String, dynamic> map) {
    return ticktick_Model(
      tick_id: map['tick_id'],
      tick_uid: map['tick_uid'] ?? '',
      circle_id: map['circle_id'] ?? '',
      user_id: map['user_id'] ?? '',
      tick_topic: map['tick_topic'] ?? '',
      ticklist_list: map['ticklist_list'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory ticktick_Model.fromJson(String source) =>
      ticktick_Model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(tick_id: $tick_id, tick_uid: $tick_uid, circle_id: $circle_id, user_id: $user_id, tick_topic: $tick_topic, ticklist_list: $ticklist_list';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ticktick_Model &&
        other.tick_id == tick_id &&
        other.tick_uid == tick_uid &&
        other.circle_id == circle_id &&
        other.user_id == user_id &&
        other.tick_topic == tick_topic &&
        other.ticklist_list == ticklist_list;
  }

  @override
  int get hashCode {
    return tick_id.hashCode ^
        tick_uid.hashCode ^
        circle_id.hashCode ^
        user_id.hashCode ^
        tick_topic.hashCode ^
        ticklist_list.hashCode;
  }
}
