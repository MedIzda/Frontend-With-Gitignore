import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class EventState with ChangeNotifier {
  int _eventsToday = 0;

  int get eventsToday => _eventsToday;

  void updateEventsToday() {
    _eventsToday = kEvents[DateTime.now()]?.length ?? 0;
    notifyListeners();
  }
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

int getNumberofEvents() {
  if (kEvents[DateTime.now()] == null) {
    return 0;
  } else {
    return kEvents[DateTime.now()]!.length;
  }
}

_retrievePatients() async {
  patients = [];
  List response = json
      .decode((await client.get(Uri.http('127.0.0.1:8000', 'patients'))).body);
  for (var element in response) {
    patients.add(Patient.fromJson(element));
  }
  patientsFiltered = patients;
  setState(() {});
}

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event('Event ${index + 1} \t start | end'))
}..addAll({
    kToday: [
      const Event('Event 1 \t start | end'),
      const Event('Event 2 \t start | end'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
