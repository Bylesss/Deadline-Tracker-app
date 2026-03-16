import 'package:flutter/foundation.dart';

class Deadline {
  final String title;
  final DateTime date;
  Deadline({required this.title, required this.date});
}

class DeadlineStore {
  static final DeadlineStore _instance = DeadlineStore._internal();
  factory DeadlineStore() => _instance;
  DeadlineStore._internal();

  final ValueNotifier<List<Deadline>> deadlines = ValueNotifier([]);
}
