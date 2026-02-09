import 'package:flutter/material.dart';
import 'deadline_upload.dart';
import 'calendar.dart';
import 'styles.dart';

void main() {
  // Entry point of the Flutter application
  runApp(
    MaterialApp(
      title: 'Deadline Tracker',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/upload': (context) => deadlineUpload(),
        '/calendar': (context) => calendar(),
      },
    ),
  );
}

void uploadCSV() {
  //this will contain logic to upload csv
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Deadline Tracker', home: HomeScreen());
  }
}

//home screen class
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deadline Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Deadline Tracker!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/upload'),
              child: const Text('Upload Deadline CSV'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/calendar'),
              child: const Text('View Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
