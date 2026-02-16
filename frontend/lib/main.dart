import 'package:flutter/material.dart';
import 'deadline_upload.dart';
import 'calendar.dart';
import 'pomodoro.dart';
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
        '/pomodoro': (context) => pomodoro(),
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
    return const MaterialApp(title: 'Deadline Tracker', home: HomeScreen());
  }
}

//home screen class
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deadline Tracker'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Deadline Tracker!',
              style: kHeadingTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/upload'),
              style: kElevatedButtonStyle(kPrimaryColor),
              child: const Text('Upload Deadline CSV'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/calendar'),
              style: kElevatedButtonStyle(kSecondaryColor),
              child: const Text('View Calendar'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/pomodoro'),
              style: kElevatedButtonStyle(kPrimaryColor),
              child: const Text('Start Pomodoro Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
