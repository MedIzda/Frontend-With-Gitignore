import 'package:flutter/material.dart';
import 'package:medizda/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_utility.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MonthlyCalendar extends StatefulWidget {
  const MonthlyCalendar({super.key});

  @override
  State<MonthlyCalendar> createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;
  final kToday = DateTime.now();
  late DateTime kFirstDay; 
  late DateTime kLastDay;
  late LinkedHashMap<DateTime, List<Event>> _kEventSource;
  LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap();
  List<Event> appointments = List.empty();

  @override
  Widget build(BuildContext context) {
    return content();
  }

  @override
  void initState() {
    super.initState();
    kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    print('\ninit\n');
    _retrieveAppointments();

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

  int getNumberofEvents() {
    if (kEvents[DateTime.now()] == null) {
      return 0;
    } else {
      return kEvents[DateTime.now()]!.length;
    }
  }

  void loadEvents(){
    _kEventSource = LinkedHashMap();
    for (var appointment in appointments){
      if(_kEventSource[DateTime.utc(appointment.date.year, appointment.date.month, appointment.date.day)] != null){
        _kEventSource[DateTime.utc(appointment.date.year, appointment.date.month, appointment.date.day)]?.add(appointment);
      }else{
        _kEventSource[DateTime.utc(appointment.date.year, appointment.date.month, appointment.date.day)] = [appointment];
      } 
    }
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: (DateTime key) => key.day * 1000000 + key.month * 10000 + key.year,
    )..addAll(_kEventSource);
    setState(() {
        _selectedDay = DateTime.now();
        _focusedDay = DateTime.now();
      });
      _selectedEvents.value = _getEventsForDay(DateTime.now());
  }

  void _retrieveAppointments() async{
    appointments = [];
    http.Client client = http.Client();
    List response = json.decode(
      (await client.get(Uri.http('127.0.0.1:8000', 'appointments'))).body);
    for (var element in response) {
      appointments.add(Event.fromJson(element));
    }
    loadEvents();
    // appointmentsFiltered = appointments;
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
                      Event(title: 'Event ${(kEvents[_focusedDay]?.length ?? 0) + 1}', date: DateTime.now(), patient: 'a', clinic: 1)
                    );
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
