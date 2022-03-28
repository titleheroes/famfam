import 'dart:convert';

class CalendarModel {
  final String? id;
  final String title;
  final String location;
  final String note;
  final String date;
  final String time_start;
  final String time_end;
  final String repeating;
  final String user_id;
  final String circle_id;
  CalendarModel({
    this.id,
    required this.title,
    required this.location,
    required this.note,
    required this.date,
    required this.time_start,
    required this.time_end,
    required this.repeating,
    required this.user_id,
    required this.circle_id,
  });

  CalendarModel copyWith({
    String? id,
    String? title,
    String? location,
    String? note,
    String? date,
    String? time_start,
    String? time_end,
    String? repeating,
    String? user_id,
    String? circle_id,
  }) {
    return CalendarModel(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      note: note ?? this.note,
      date: date ?? this.date,
      time_start: time_start ?? this.time_start,
      time_end: time_end ?? this.time_end,
      repeating: repeating ?? this.repeating,
      user_id: user_id ?? this.user_id,
      circle_id: circle_id ?? this.circle_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'note': note,
      'date': date,
      'time_start': time_start,
      'time_end': time_end,
      'repeating': repeating,
      'user_id': user_id,
      'circle_id': circle_id,
    };
  }

  factory CalendarModel.fromMap(Map<String, dynamic> map) {
    return CalendarModel(
      id: map['id'],
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      note: map['note'] ?? '',
      date: map['date'] ?? '',
      time_start: map['time_start'] ?? '',
      time_end: map['time_end'] ?? '',
      repeating: map['repeating'] ?? '',
      user_id: map['user_id'] ?? '',
      circle_id: map['circle_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarModel.fromJson(String source) =>
      CalendarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CalendarModel(id: $id, title: $title, location: $location, note: $note,date: $date, time_start: $time_start, time_end: $time_end, repeating: $repeating, user_id: $user_id, circle_id: $circle_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarModel &&
        other.id == id &&
        other.title == title &&
        other.location == location &&
        other.note == note &&
        other.date == date &&
        other.time_start == time_start &&
        other.time_end == time_end &&
        other.repeating == repeating &&
        other.user_id == user_id &&
        other.circle_id == circle_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        location.hashCode ^
        note.hashCode ^
        date.hashCode ^
        time_start.hashCode ^
        time_end.hashCode ^
        repeating.hashCode ^
        user_id.hashCode ^
        circle_id.hashCode;
  }
}
