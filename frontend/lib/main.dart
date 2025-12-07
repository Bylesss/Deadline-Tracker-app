import 'package:flutter/material.dart';



void main() {
  // Entry point of the Flutter application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deadline Tracker',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deadline Tracker'),
      ),
      body: Center(
        child: Text(
            'Welcome to Deadline Tracker!',
            style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}