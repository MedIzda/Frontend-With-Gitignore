import 'package:flutter/material.dart';
import 'package:medizda/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_utility.dart';

class MonthlyCalendar extends StatefulWidget {
  const MonthlyCalendar({super.key});

  @override
  State<MonthlyCalendar> createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  Widget build(BuildContext context) {
    return content();
  }

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void addEvent(DateTime day, Event event) {
    if (kEvents[day] == null) {
      kEvents[day] = [event];
    } else {
      kEvents[day]?.add(event);
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
    _selectedEvents.value = _getEventsForDay(selectedDay);
  }

  Widget content() {
    return Container(
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        alignment: Alignment.center,
        height: 500,
        child: Column(
          children: [
            TableCalendar<Event>(
              headerStyle: (const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true)),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  addEvent(
                      _focusedDay,
                      Event(
                          'Event ${(kEvents[_focusedDay]?.length ?? 0) + 1} \t start | end'));
                  setState(() {});
                },
                style: TextButton.styleFrom(
                  foregroundColor: backgroundColor,
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                child: const Text('Add Event'),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
