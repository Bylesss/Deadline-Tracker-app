import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'styles.dart';

// The type of pomodoro session currently active.
enum SessionType { work, shortBreak, longBreak }

class pomodoro extends StatefulWidget {
  const pomodoro({super.key});

  @override
  State<pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<pomodoro> {
  //Duration settings
  static const int _workDuration = 25 * 60;
  static const int _shortBreakDuration = 5 * 60;
  static const int _longBreakDuration = 15 * 60;

  //State
  Timer? _timer;
  int _remainingSeconds = _workDuration;
  int _totalSeconds = _workDuration;
  bool _isRunning = false;
  SessionType _sessionType = SessionType.work;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  //Helpers

  Color get _sessionColor {
    switch (_sessionType) {
      case SessionType.work:
        return kWarningColor;
      case SessionType.shortBreak:
        return kAccentColor;
      case SessionType.longBreak:
        return kPrimaryColor;
    }
  }

  String get _sessionLabel {
    switch (_sessionType) {
      case SessionType.work:
        return 'Focus Time';
      case SessionType.shortBreak:
        return 'Short Break';
      case SessionType.longBreak:
        return 'Long Break';
    }
  }

  String get _sessionSubtitle {
    switch (_sessionType) {
      case SessionType.work:
        return 'Stay focused on your task';
      case SessionType.shortBreak:
        return 'Take a quick breather';
      case SessionType.longBreak:
        return 'You earned a longer rest!';
    }
  }

  int _durationForSession(SessionType type) {
    switch (type) {
      case SessionType.work:
        return _workDuration;
      case SessionType.shortBreak:
        return _shortBreakDuration;
      case SessionType.longBreak:
        return _longBreakDuration;
    }
  }

  String _formatTime(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get _progress {
    if (_totalSeconds == 0) return 1.0;
    return 1.0 - (_remainingSeconds / _totalSeconds);
  }

  //Timer controls

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds <= 0) {
        _onSessionComplete();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _durationForSession(_sessionType);
      _totalSeconds = _remainingSeconds;
      _isRunning = false;
    });
  }

  void _onSessionComplete() {
    _timer?.cancel();

    setState(() {
      _isRunning = false;
      _remainingSeconds = 0;
    });

    _showSessionCompleteDialog();
  }

  void _switchSession(SessionType type) {
    _timer?.cancel();
    setState(() {
      _sessionType = type;
      _totalSeconds = _durationForSession(type);
      _remainingSeconds = _totalSeconds;
      _isRunning = false;
    });
  }

  void _showSessionCompleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: kSuccessColor, size: 28),
            const SizedBox(width: 10),
            const Text('Session Complete!', style: kSubheadingTextStyle),
          ],
        ),
        content: const Text(
          'Great work! Choose your next session type above.',
          style: kBodyTextStyle,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  //Build

  @override
  Widget build(BuildContext context) {
    final color = _sessionColor;

    return Scaffold(
      appBar: AppBar(title: const Text('Pomodoro Timer')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPagePadding),
          child: Column(
            children: [
              const SizedBox(height: 8),

              //Session type selecton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: SessionType.values.map((type) {
                  final selected = type == _sessionType;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(
                        type == SessionType.work
                            ? 'Work'
                            : type == SessionType.shortBreak
                            ? 'Short'
                            : 'Long',
                      ),
                      selected: selected,
                      selectedColor: _sessionColorForType(type).withAlpha(40),
                      labelStyle: TextStyle(
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: selected
                            ? _sessionColorForType(type)
                            : kTextSecondary,
                      ),
                      side: BorderSide(
                        color: selected
                            ? _sessionColorForType(type)
                            : kDividerColor,
                      ),
                      onSelected: _isRunning
                          ? null
                          : (_) => _switchSession(type),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(flex: 1),

              //Header
              Text(_sessionLabel, style: kSubheadingTextStyle),
              const SizedBox(height: 4),
              Text(
                _sessionSubtitle,
                style: kCaptionTextStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: kSectionSpacing),

              //Circular timer
              SizedBox(
                width: 230,
                height: 230,
                child: CustomPaint(
                  painter: _TimerRingPainter(progress: _progress, color: color),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(_remainingSeconds),
                          style: kTimerTextStyle.copyWith(color: color),
                        ),
                        Text(
                          _isRunning
                              ? 'Running'
                              : (_progress > 0 ? 'Paused' : 'Ready'),
                          style: kCaptionTextStyle.copyWith(
                            color: color.withAlpha(180),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: kSectionSpacing + 8),

              //Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    child: ElevatedButton.icon(
                      onPressed: _isRunning ? _pauseTimer : _startTimer,
                      style: kElevatedButtonStyle(
                        _isRunning ? kTextSecondary : color,
                      ),
                      icon: Icon(
                        _isRunning
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                      label: Text(_isRunning ? 'Pause' : 'Start'),
                    ),
                  ),
                  const SizedBox(width: kItemSpacing),
                  SizedBox(
                    width: 140,
                    child: OutlinedButton.icon(
                      onPressed: _resetTimer,
                      style: kOutlinedButtonStyle(kErrorColor),
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Reset'),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Color _sessionColorForType(SessionType type) {
    switch (type) {
      case SessionType.work:
        return kWarningColor;
      case SessionType.shortBreak:
        return kAccentColor;
      case SessionType.longBreak:
        return kPrimaryColor;
    }
  }
}

//Custom painter for the circular progress ring
class _TimerRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _TimerRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 6.0;

    //Background track
    final bgPaint = Paint()
      ..color = color.withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    //Progress arc
    if (progress > 0) {
      final fgPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, //start at top
        2 * pi * progress,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_TimerRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
