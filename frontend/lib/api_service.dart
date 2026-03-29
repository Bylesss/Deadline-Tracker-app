import 'dart:convert';
import 'package:http/http.dart' as http;
import 'deadline_store.dart';

class ApiService {
  // Configure at build/run time with:
  // --dart-define=API_BASE_URL=http://host:8000
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  // Optional admin token used for privileged operations.
  static const String adminToken = String.fromEnvironment(
    'ADMIN_TOKEN',
    defaultValue: '',
  );

  // Upload CSV file to backend (supports both web and desktop)
  static Future<Map<String, dynamic>> uploadCsv(dynamic fileData, String fileName) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-csv'),
      );

      // Add the file based on platform
      if (fileData is List<int>) {
        // Web platform or bytes: fileData is bytes
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            fileData,
            filename: fileName,
          ),
        );
      } else {
        // Desktop/Mobile platform: fileData is File with path
        request.files.add(
          await http.MultipartFile.fromPath('file', fileData.path),
        );
      }

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle error response
        var errorData = json.decode(response.body);
        throw Exception(errorData['detail'] ?? 'Upload failed');
      }
    } catch (e) {
      throw Exception('Failed to upload CSV: $e');
    }
  }

  // Get all deadlines from backend
  static Future<List<Deadline>> getDeadlines() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/deadlines'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> deadlinesList = data['deadlines'];
        
        return deadlinesList.map((json) {
          return Deadline(
            title: json['title'],
            date: DateTime.parse(json['date']),
          );
        }).toList();
      } else {
        throw Exception('Failed to load deadlines');
      }
    } catch (e) {
      throw Exception('Failed to fetch deadlines: $e');
    }
  }

  // Delete all deadlines
  static Future<Map<String, dynamic>> deleteAllDeadlines() async {
    try {
      final headers = <String, String>{};
      if (adminToken.isNotEmpty) {
        headers['X-Admin-Token'] = adminToken;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/deadlines'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to delete deadlines');
      }
    } catch (e) {
      throw Exception('Failed to delete deadlines: $e');
    }
  }
}
