import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../home/monthly_calendar.dart';
import 'detailed_patient.dart';

class PatientDetails extends StatelessWidget {
  const PatientDetails({super.key, @required this.pesel});

  final String? pesel;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 600,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
              width: double.infinity, child: PatientDetalisView(pesel: pesel)),
        ));
  }
}

class PatientDetalisView extends StatefulWidget {
  final String? pesel;

  const PatientDetalisView({super.key, @required this.pesel});

  @override
  State<PatientDetalisView> createState() => _PatientDetalisViewState();
}

class _PatientDetalisViewState extends State<PatientDetalisView> {
  http.Client client = http.Client();
  DetailedPatient? patient;

  @override
  void didUpdateWidget(covariant PatientDetalisView oldWidget) {
    if (widget.pesel != oldWidget.pesel) {
      retrievePatients();
    }
    super.didUpdateWidget(oldWidget);
  }

  retrievePatients() async {
    if (widget.pesel == null) {
      return;
    } else {
      var response = json.decode((await client
              .get(Uri.http('127.0.0.1:8000', 'patients/${widget.pesel}')))
          .body);
      patient = DetailedPatient.fromJson(response);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (patient == null) {
      return const Center(child: Text('N O   P A T I E N T   S E L E C T E D'));
    } else {
      return Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: 200,
              height: 400,
              child: ListView(
                children: [
                  ListTile(
                      title: Text(
                    patient!.name,
                    style: const TextStyle(fontSize: 24),
                  )),
                  ListTile(
                      title: Text(
                    patient!.surname,
                    style: const TextStyle(fontSize: 24),
                  )),
                  ListTile(
                      title: Text(
                    patient!.pesel,
                    style: const TextStyle(fontSize: 24),
                  ))
                ],
              ),
            ),
            const Spacer(),
            const ScheduleMeetingCalendarPopUp(),
            const SizedBox(width: defaultPadding)
          ]),
          DropdownButton(
            value: null,
            hint: const Text('what do you want to do?',
                style: TextStyle(color: Colors.black)),
            items: ['prescription', 'vaccination', 'sick leave']
                .map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ],
      );
    }
  }
}

class ScheduleMeetingCalendarPopUp extends StatelessWidget {
  const ScheduleMeetingCalendarPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return const _AddTodoPopupCard();
        }));
      },
      child: Hero(
        tag: _heroScheduleMeeting,
        child: Material(
          type: MaterialType.button,
          color: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Container(
            width: 256,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(32)),
            child: const ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.add, color: backgroundColor),
              title: Text('ARRANGE AN APPOINTMENT'),
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroScheduleMeeting = 'schedule-meeting-hero';

class _AddTodoPopupCard extends StatelessWidget {
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 600,
        child: Hero(
          tag: _heroScheduleMeeting,
          child: Material(
            color: primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 3,
                    child: SingleChildScrollView(child: MonthlyCalendar()),
                  ),
                  const SizedBox(width: defaultPadding),
                  const VerticalDivider(color: Colors.black, width: 0.1),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      const SizedBox(height: defaultPadding),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('Name'),
                        ),
                        cursorColor: Colors.white,
                      ),
                      const SizedBox(height: defaultPadding),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('Surname'),
                        ),
                        cursorColor: Colors.white,
                      ),
                      const SizedBox(height: defaultPadding),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('Pesel'),
                        ),
                        cursorColor: Colors.white,
                      ),
                      const SizedBox(height: defaultPadding),
                      InputDatePickerFormField(
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now(),
                      ),
                      const SizedBox(height: defaultPadding),
                      const Spacer(),
                      SizedBox(
                        height: 64,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(backgroundColor)),
                            onPressed: () {},
                            child: const Text('PLACEHOLDER ADD',
                                style: TextStyle(color: Colors.white))),
                      ),
                      const SizedBox(height: defaultPadding)
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
