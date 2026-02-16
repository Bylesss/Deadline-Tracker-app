import 'package:flutter/material.dart';
import 'deadline_upload.dart';
import 'calendar.dart';
import 'pomodoro.dart';
import 'styles.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Deadline Tracker',
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/upload': (context) => const deadlineUpload(),
        '/calendar': (context) => const calendar(),
        '/pomodoro': (context) => const pomodoro(),
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
      appBar: AppBar(title: const Text('Deadline Tracker')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Text('Welcome back', style: kHeadingTextStyle),
              const SizedBox(height: 4),
              const Text(
                'What would you like to do today?',
                style: kBodyTextStyle,
              ),
              const SizedBox(height: kSectionSpacing),
              _NavCard(
                icon: Icons.upload_file_rounded,
                title: 'Upload Deadlines',
                subtitle: 'Import your deadline CSV file',
                color: kPrimaryColor,
                onTap: () => Navigator.pushNamed(context, '/upload'),
              ),
              const SizedBox(height: kItemSpacing),
              _NavCard(
                icon: Icons.calendar_month_rounded,
                title: 'Calendar',
                subtitle: 'View and manage your schedule',
                color: kAccentColor,
                onTap: () => Navigator.pushNamed(context, '/calendar'),
              ),
              const SizedBox(height: kItemSpacing),
              _NavCard(
                icon: Icons.timer_rounded,
                title: 'Pomodoro Timer',
                subtitle: 'Stay focused with timed sessions',
                color: kWarningColor,
                onTap: () => Navigator.pushNamed(context, '/pomodoro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _NavCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSurfaceColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(kCardPadding),
          decoration: kCardDecoration,
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: kSubheadingTextStyle),
                    const SizedBox(height: 2),
                    Text(subtitle, style: kCaptionTextStyle),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: kTextHint, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
