import 'package:flutter/material.dart';
import 'styles.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedMonth = DateTime.now();

  List<String> get _weekDays => [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _firstWeekdayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _daysInMonth(_focusedMonth);
    final firstWeekday = _firstWeekdayOfMonth(_focusedMonth);
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Padding(
        padding: const EdgeInsets.all(kPagePadding),
        child: Column(
          children: [
            // Month navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: kCardDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _focusedMonth = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month - 1,
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_left_rounded, size: 28),
                    splashRadius: 22,
                  ),
                  Text(
                    '${monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                    style: kSubheadingTextStyle,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _focusedMonth = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month + 1,
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_right_rounded, size: 28),
                    splashRadius: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: kItemSpacing),
            // Weekday headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _weekDays
                  .map(
                    (day) => SizedBox(
                      width: 40,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: kCaptionTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: kTextSecondary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            // Calendar grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemCount: firstWeekday + daysInMonth,
                itemBuilder: (context, index) {
                  if (index < firstWeekday) {
                    return const SizedBox.shrink();
                  }
                  final day = index - firstWeekday + 1;
                  final isSelected =
                      day == _selectedDate.day &&
                      _focusedMonth.month == _selectedDate.month &&
                      _focusedMonth.year == _selectedDate.year;
                  final isToday =
                      day == DateTime.now().day &&
                      _focusedMonth.month == DateTime.now().month &&
                      _focusedMonth.year == DateTime.now().year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month,
                          day,
                        );
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: isSelected
                          ? kSelectedDecoration
                          : isToday
                          ? kTodayDecoration
                          : null,
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isToday || isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected ? Colors.white : kTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
