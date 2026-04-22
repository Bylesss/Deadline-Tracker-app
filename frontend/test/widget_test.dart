import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';

void main() {
  testWidgets('shows role selection on startup', (WidgetTester tester) async {
    await tester.pumpWidget(const DeadlineTrackerApp());

    expect(find.text('Who are you?'), findsOneWidget);
    expect(find.byIcon(Icons.school_rounded), findsOneWidget);
    expect(find.byIcon(Icons.badge_rounded), findsOneWidget);
  });
}
