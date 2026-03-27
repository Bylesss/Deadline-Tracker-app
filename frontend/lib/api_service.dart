import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'deadline_store.dart';

// Only import dart:io on non-web platforms
import 'dart:io' if (dart.library.js) 'stub_file.dart';

class ApiService {
  // TODO: Update this URL based on where backend runs
  // For development: localhost with appropriate port
  // For production: your deployed backend URL
  static const String baseUrl = 'http://localhost:8000';

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
      final response = await http.delete(
        Uri.parse('$baseUrl/deadlines'),
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
