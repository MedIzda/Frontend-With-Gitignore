import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../constants.dart';

/// Example event class.
class Event {
  String title;
  DateTime date;
  String patient;
  String clinic;

  Event({
    required this.title,
    required this.date,
    required this.patient,
    required this.clinic,
  });

  factory Event.fromJson(dynamic json) {
    return Event(
        title: "json['title']", date: json['date'], patient: json['patient'], clinic: json['clinic']);
  }

  @override
  String toString() => '$title \t|\t Start - ${date.hour}:${date.minute} \t|\t Patient - $patient \t|\t Clinic - $clinic';
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

Future<List<Event>> _retrieveAppointments() async {
  http.Client client = http.Client();
  List<Event> appointments = [];
  List response = json.decode(
    (await client.get(Uri.http('127.0.0.1:8000', 'appointments'))).body);
  for (var element in response) {
    appointments.add(Event.fromJson(element));
  }
  // appointmentsFiltered = appointments;
  return appointments;
}

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event(title: 'Event ${index + 1}', date: DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
                                                   patient: 'x', clinic: 'y'))
}..addAll({
    kToday: [
      Event(title: 'Event 1', date: DateTime.now(), patient: 'x', clinic: 'y'),
      Event(title: 'Event 2', date: DateTime.now(), patient: 'x', clinic: 'y'),
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
