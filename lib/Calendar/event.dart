// ignore_for_file: annotate_overrides

// ignore: unused_import
import 'package:flutter/foundation.dart';

class Event {
  final String title;
  final String locations;
  Event({required this.title, required this.locations});

  // ignore: unnecessary_this
  String toString() => this.title;
  String toSring() => this.locations;
}
