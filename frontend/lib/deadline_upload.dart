import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'styles.dart';
import 'deadline_store.dart';
import 'api_service.dart';

// Only import dart:io on non-web platforms
import 'dart:io' if (dart.library.js) 'stub_file.dart';

class deadlineUpload extends StatefulWidget {
  const deadlineUpload({super.key});

  @override
  State<deadlineUpload> createState() => _deadlineUploadState();
}

class _deadlineUploadState extends State<deadlineUpload> {
  List<Deadline> _deadlines = [];
  String? _error;
  bool _isUploading = false;

  Future<void> _pickAndUploadCSV() async {
    setState(() {
      _error = null;
      _isUploading = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        withData: true, // Important for web
      );

      if (result != null) {
        dynamic fileData;
        String fileName = result.files.single.name;
        
        // Handle different platforms
        if (kIsWeb) {
          // Web platform: use bytes
          if (result.files.single.bytes != null) {
            fileData = result.files.single.bytes!;
          } else {
            throw Exception('No file data available on web');
          }
        } else {
          // Desktop/Mobile platform: create File from path
          final filePath = result.files.single.path;
          if (filePath != null) {
            fileData = File(filePath);
          } else {
            throw Exception('No file path available');
          }
        }
        
        // Upload to backend
        final response = await ApiService.uploadCsv(fileData, fileName);
        
        // Parse response
        List<dynamic> deadlinesList = response['deadlines'];
        final parsed = deadlinesList.map((json) {
          return Deadline(
            title: json['title'],
            date: DateTime.parse(json['date']),
          );
        }).toList();

        setState(() {
          _deadlines = parsed;
        });

        // Update global store
        await DeadlineStore().loadDeadlines();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message']),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _error = 'Upload failed: ${e.toString()}';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Deadlines')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPagePadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.upload_file_rounded,
                  size: 42,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: kSectionSpacing),
              const Text(
                'Import Deadlines',
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload a CSV file to quickly add all\nyour upcoming deadlines.',
                style: kBodyTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kSectionSpacing),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isUploading ? null : _pickAndUploadCSV,
                  icon: _isUploading 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.file_open_rounded),
                  label: Text(_isUploading ? 'Uploading...' : 'Choose CSV File'),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              if (_deadlines.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Uploaded Deadlines:', style: kSubheadingTextStyle),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: _deadlines.length,
                    itemBuilder: (context, i) {
                      final d = _deadlines[i];
                      return ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.green),
                        title: Text(d.title),
                        subtitle: Text(d.date.toIso8601String()),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: kItemSpacing),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('CSV Format Guide'),
                        content: const Text(
                          'Your CSV file should have the following format:\n\n'
                          'title,date\n'
                          'Math Assignment,2024-12-25T23:59:59\n'
                          'Project Submission,2024-12-31T23:59:59\n\n'
                          'Date format: ISO8601 (YYYY-MM-DDTHH:MM:SS)'
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Got it'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: kOutlinedButtonStyle(kPrimaryColor),
                  icon: const Icon(Icons.info_outline_rounded),
                  label: const Text('View Format Guide'),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
