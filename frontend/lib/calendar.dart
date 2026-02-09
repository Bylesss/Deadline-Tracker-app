import 'package:flutter/material.dart';
import 'deadline_upload.dart';
import 'calendar.dart';
import 'styles.dart';

class calendar extends StatelessWidget {
  const calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar View')),
      body: const Column(
        children: [Text('this is where the calendar will go')],
      ),
    );
  }
}
