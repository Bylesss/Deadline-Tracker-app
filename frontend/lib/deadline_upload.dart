import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'styles.dart';
import 'deadline_store.dart';

class deadlineUpload extends StatefulWidget {
  const deadlineUpload({super.key});

  @override
  State<deadlineUpload> createState() => _deadlineUploadState();
}

class _deadlineUploadState extends State<deadlineUpload> {
  List<Deadline> _deadlines = [];
  String? _error;

  Future<void> _pickAndParseCSV() async {
    setState(() {
      _error = null;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      String content;
      if (result.files.single.bytes != null) {
        content = utf8.decode(result.files.single.bytes!);
      } else if (result.files.single.path != null) {
        // Fallback for desktop/mobile
        // import 'dart:io'; required for this
        // final file = File(result.files.single.path!);
        // content = await file.readAsString();
        setState(() {
          _error = 'File reading not supported on web.';
        });
        return;
      } else {
        setState(() {
          _error = 'No file content found.';
        });
        return;
      }
      try {
        final lines = LineSplitter.split(content).toList();
        final List<Deadline> parsed = [];
        for (var i = 1; i < lines.length; i++) {
          // skip header
          final row = lines[i].split(',');
          if (row.length >= 2) {
            final title = row[0].trim();
            final date = DateTime.tryParse(row[1].trim());
            if (date != null) {
              parsed.add(Deadline(title: title, date: date));
            }
          }
        }
        setState(() {
          _deadlines = parsed;
        });
        DeadlineStore().deadlines.value = parsed;
      } catch (e) {
        setState(() {
          _error = 'Failed to parse CSV.';
        });
      }
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
                  onPressed: _pickAndParseCSV,
                  icon: const Icon(Icons.file_open_rounded),
                  label: const Text('Choose CSV File'),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              if (_deadlines.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Parsed Deadlines:', style: kSubheadingTextStyle),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: _deadlines.length,
                    itemBuilder: (context, i) {
                      final d = _deadlines[i];
                      return ListTile(
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
                  onPressed: () {},
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
