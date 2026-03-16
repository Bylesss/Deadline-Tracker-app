import 'package:flutter/material.dart';
import 'styles.dart';
import 'deadline_store.dart';

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

  List<Deadline> _deadlinesForDay(List<Deadline> all, int day) {
    return all
        .where(
          (d) =>
              d.date.year == _focusedMonth.year &&
              d.date.month == _focusedMonth.month &&
              d.date.day == day,
        )
        .toList();
  }

  List<Deadline> _deadlinesForSelected(List<Deadline> all) {
    return all
        .where(
          (d) =>
              d.date.year == _selectedDate.year &&
              d.date.month == _selectedDate.month &&
              d.date.day == _selectedDate.day,
        )
        .toList();
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
      body: ValueListenableBuilder<List<Deadline>>(
        valueListenable: DeadlineStore().deadlines,
        builder: (context, allDeadlines, _) {
          return Padding(
            padding: const EdgeInsets.all(kPagePadding),
            child: Column(
              children: [
                // Month navigation
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                      final dayDeadlines = _deadlinesForDay(allDeadlines, day);
                      final hasDeadline = dayDeadlines.isNotEmpty;

                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _selectedDate = DateTime(
                              _focusedMonth.year,
                              _focusedMonth.month,
                              day,
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: isSelected
                                ? kSelectedDecoration
                                : isToday
                                ? kTodayDecoration
                                : null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isToday || isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? Colors.white
                                        : kTextPrimary,
                                  ),
                                ),
                                if (hasDeadline)
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white
                                          : kPrimaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Deadlines for selected day
                Builder(
                  builder: (context) {
                    final selected = _deadlinesForSelected(allDeadlines);
                    if (selected.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kItemSpacing),
                        const Divider(),
                        Text(
                          'Deadlines on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: kSubheadingTextStyle,
                        ),
                        const SizedBox(height: 8),
                        ...selected.map(
                          (d) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(d.title, style: kBodyTextStyle),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
