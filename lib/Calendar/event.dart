// ignore_for_file: annotate_overrides

// ignore: unused_import
import 'package:flutter/foundation.dart';

class Event {
  final String title;
  final String locations;
  final String note;

  Event({required this.title, required this.locations, required this.note});

  // ignore: unnecessary_this
  String toString() => this.title;
  String toSring() => this.locations;
  String toSring1() => this.note;
}
