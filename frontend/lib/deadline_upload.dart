import 'package:flutter/material.dart';

class deadlineUpload extends StatelessWidget {
  const deadlineUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Deadlines')),
      body: Column(
        children: [
          const Text(
            'Upload your deadline CSV file here.',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Upload CSV')),
        ],
      ),
    );
  }
}
