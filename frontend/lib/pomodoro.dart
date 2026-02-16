import 'package:flutter/material.dart';
import 'styles.dart';

class pomodoro extends StatelessWidget {
  const pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Pomodoro Timer',
              style: kHeadingTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Text(
              '25:00',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: kElevatedButtonStyle(kSecondaryColor),
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  label: const Text('Start'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: kElevatedButtonStyle(Colors.red),
                  icon: const Icon(Icons.stop, color: Colors.white),
                  label: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
