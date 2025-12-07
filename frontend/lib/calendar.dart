import 'package:flutter/material.dart';
import 'deadline_upload.dart';
import 'calendar.dart';
import 'styles.dart';

class calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
      ),
      body: Column(
        children: [Text('Calendar Functionality Here'),
        ],
      ),
    );
  }
}