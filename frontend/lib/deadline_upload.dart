import 'package:flutter/material.dart';
import 'styles.dart';

class deadlineUpload extends StatelessWidget {
  const deadlineUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Deadlines'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Upload your deadline CSV file here.',
              style: kHeadingTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: kElevatedButtonStyle(kPrimaryColor),
              child: const Text('Upload CSV'),
            ),
          ],
        ),
      ),
    );
  }
}
