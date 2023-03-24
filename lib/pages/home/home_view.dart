import 'package:flutter/material.dart';
import 'package:medizda/constants.dart';

import '../shared_components/header.dart';
import 'calendar_utility.dart';
import 'monthly_calendar.dart';

late ValueNotifier<int> todays_number;

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: const [
            Header(text: 'HomeView'),
            SizedBox(height: defaultPadding),
            HomeViewContents()
          ],
        ),
      ),
    );
  }
}

class HomeViewContents extends StatelessWidget {
  const HomeViewContents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(
          flex: 3,
          child: LeftSide(),
        ),
        SizedBox(height: defaultPadding, width: defaultPadding),
        Expanded(
          flex: 3,
          child: MonthlyCalendar(),
        )
      ],
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Row(children: const [
            Expanded(child: AddClinic()),
            SizedBox(width: defaultPadding),
            Expanded(child: AddPatient()),
            SizedBox(width: defaultPadding),
            Expanded(child: Personalize()),
          ]),
        ),
        const SizedBox(height: defaultPadding),
        const WeeklyCalendar(),
      ],
    );
  }
}

class WeeklyCalendar extends StatefulWidget {
  const WeeklyCalendar({super.key});

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  late final ValueNotifier<List<Event>> _todaysEvents;

  @override
  void initState() {
    super.initState();
    _todaysEvents = ValueNotifier([]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            const WeeklyCalendarHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _todaysEvents,
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
                            title: Text('Today\'s ${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}

class AddClinic extends StatelessWidget {
  const AddClinic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        child: const Text('A D D   C L I N I C',
            style: TextStyle(color: Colors.black)));
  }
}

class AddPatient extends StatelessWidget {
  const AddPatient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        child: const Text('A D D   P A T I E N T',
            style: TextStyle(color: Colors.black)));
  }
}

class Personalize extends StatelessWidget {
  const Personalize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        child: const Text('P E R S O N A L I Z E',
            style: TextStyle(color: Colors.black)));
  }
}

class WeeklyCalendarHeader extends StatefulWidget {
  const WeeklyCalendarHeader({super.key});

  @override
  State<WeeklyCalendarHeader> createState() => _WeeklyCalendarHeaderState();
}

class _WeeklyCalendarHeaderState extends State<WeeklyCalendarHeader> {
  late final ValueNotifier<List<Event>> _todaysEvents;

  @override
  void initState() {
    super.initState();
    _todaysEvents = ValueNotifier([]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ValueListenableBuilder<List<Event>>(
            valueListenable: _todaysEvents,
            builder: (context, value, _) {
              return Text(
                  'You have ${_todaysEvents.value.length} appointments scheduled for today',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold));
            }));
  }
}
