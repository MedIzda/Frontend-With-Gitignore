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
  int clinic;

  Event({
    required this.title,
    required this.date,
    required this.patient,
    required this.clinic,
  });

  factory Event.fromJson(dynamic json) {
    String date_db = json['date'];
    date_db = date_db.replaceAll(RegExp(r'Z'), '');
    date_db = date_db.replaceAll(RegExp(r'T'), ' ');
    date_db += '.000';
    return Event(
        title: "json['title']", date: DateTime.parse(date_db), patient: json['patient'], clinic: json['clinic']);
  }

  @override
  String toString() => '$title \t|\t Start - ${date.hour}:${date.minute} \t|\t Patient - $patient \t|\t Clinic - $clinic';
}

// class EventState with ChangeNotifier {
//   int _eventsToday = 0;

//   int get eventsToday => _eventsToday;

//   void updateEventsToday() {
//     _eventsToday = kEvents[DateTime.now()]?.length ?? 0;
//     notifyListeners();
//   }
// }

// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// int getNumberofEvents() {
//   if (kEvents[DateTime.now()] == null) {
//     return 0;
//   } else {
//     return kEvents[DateTime.now()]!.length;
//   }
// }

// void _retrieveAppointments() async {
//   http.Client client = http.Client();
//   appointments = [];
//   List response = json.decode(
//     (await client.get(Uri.http('127.0.0.1:8000', 'appointments'))).body);
//   for (var element in response) {
//     appointments.add(Event.fromJson(element));
//   }
//   // appointmentsFiltered = appointments;
// } 

// final _kEventSource = { };

// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }

// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
