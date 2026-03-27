import 'package:flutter/material.dart';
import 'deadline_upload.dart';
import 'calendar.dart';
import 'pomodoro.dart';
import 'styles.dart';
import 'deadline_store.dart';

enum UserRole { student, staff }

void main() {
  runApp(const DeadlineTrackerApp());
}

class DeadlineTrackerApp extends StatefulWidget {
  const DeadlineTrackerApp({super.key});

  @override
  State<DeadlineTrackerApp> createState() => _DeadlineTrackerAppState();
}

class _DeadlineTrackerAppState extends State<DeadlineTrackerApp> {
  UserRole? _selectedRole;

  @override
  void initState() {
    super.initState();
    // Load deadlines from backend on app start
    _loadDeadlines();
  }

  Future<void> _loadDeadlines() async {
    await DeadlineStore().loadDeadlines();
  }

  void _setRole(UserRole role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _changeRole() {
    setState(() {
      _selectedRole = null;
    });
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final role = _selectedRole;
    switch (settings.name) {
      case '/upload':
        if (role == null) {
          return MaterialPageRoute(
            builder: (_) => RoleSelectionScreen(onRoleSelected: _setRole),
          );
        }
        if (role == UserRole.student) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(
              userRole: UserRole.student,
              onChangeRole: _changeRole,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const deadlineUpload());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => const calendar());
      case '/pomodoro':
        return MaterialPageRoute(builder: (_) => const pomodoro());
      default:
        return MaterialPageRoute(
          builder: (_) => role == null
              ? RoleSelectionScreen(onRoleSelected: _setRole)
              : HomeScreen(userRole: role, onChangeRole: _changeRole),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deadline Tracker',
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      onGenerateRoute: _onGenerateRoute,
      initialRoute: '/',
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  final ValueChanged<UserRole> onRoleSelected;

  const RoleSelectionScreen({super.key, required this.onRoleSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deadline Tracker')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'Who are you?',
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your role to continue.',
                style: kBodyTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kSectionSpacing),
              ElevatedButton.icon(
                onPressed: () {
                  onRoleSelected(UserRole.student);
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.school_rounded),
                label: const Text('I am a Student'),
              ),
              const SizedBox(height: kItemSpacing),
              ElevatedButton.icon(
                onPressed: () {
                  onRoleSelected(UserRole.staff);
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.badge_rounded),
                label: const Text('I am a Staff Member'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

//home screen class
class HomeScreen extends StatelessWidget {
  final UserRole userRole;
  final VoidCallback onChangeRole;

  const HomeScreen({
    super.key,
    required this.userRole,
    required this.onChangeRole,
  });

  @override
  Widget build(BuildContext context) {
    final isStaff = userRole == UserRole.staff;
    final store = DeadlineStore();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deadline Tracker'),
        actions: [
          TextButton(
            onPressed: () {
              onChangeRole();
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            },
            child: const Text('Switch Role'),
          ),
        ],
      ),
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
              const SizedBox(height: 6),
              Text(
                isStaff
                    ? 'You are signed in as staff.'
                    : 'You are signed in as student.',
                style: kCaptionTextStyle,
              ),
              const SizedBox(height: 8),
              // Connection status indicator
              ValueListenableBuilder<String?>(
                valueListenable: store.error,
                builder: (context, error, child) {
                  if (error != null) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Backend connection failed. Check if server is running.',
                              style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: kSectionSpacing),
              if (isStaff) ...[
                _NavCard(
                  icon: Icons.upload_file_rounded,
                  title: 'Upload Deadlines',
                  subtitle: 'Import your deadline CSV file',
                  color: kPrimaryColor,
                  onTap: () => Navigator.pushNamed(context, '/upload'),
                ),
                const SizedBox(height: kItemSpacing),
              ],
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
