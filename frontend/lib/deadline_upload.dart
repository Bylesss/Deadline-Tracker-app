import 'package:flutter/material.dart';
import 'styles.dart';

class deadlineUpload extends StatelessWidget {
  const deadlineUpload({super.key});

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
                  onPressed: () {},
                  icon: const Icon(Icons.file_open_rounded),
                  label: const Text('Choose CSV File'),
                ),
              ),
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
