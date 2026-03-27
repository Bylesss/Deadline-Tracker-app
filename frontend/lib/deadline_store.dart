import 'package:flutter/foundation.dart';
import 'api_service.dart';

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
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  // Load deadlines from backend
  Future<void> loadDeadlines() async {
    isLoading.value = true;
    error.value = null;
    
    try {
      final fetchedDeadlines = await ApiService.getDeadlines();
      deadlines.value = fetchedDeadlines;
    } catch (e) {
      error.value = e.toString();
      debugPrint('Error loading deadlines: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Clear all deadlines (both locally and on backend)
  Future<void> clearDeadlines() async {
    try {
      await ApiService.deleteAllDeadlines();
      deadlines.value = [];
    } catch (e) {
      error.value = e.toString();
      debugPrint('Error clearing deadlines: $e');
    }
  }
}
