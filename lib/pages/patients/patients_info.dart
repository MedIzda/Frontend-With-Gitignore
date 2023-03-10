import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../constants.dart';
import 'add_patients.dart';
import 'patient.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({super.key, required this.updatePesel});
  final Function(String) updatePesel;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
              width: double.infinity,
              child: PatientsDatabaseView(updatePesel: updatePesel)),
        ));
  }
}

class PatientsDatabaseView extends StatefulWidget {
  final Function(String) updatePesel;

  const PatientsDatabaseView({Key? key, required this.updatePesel})
      : super(key: key);

  @override
  PatientsDatabaseViewState createState() => PatientsDatabaseViewState();
}

class PatientsDatabaseViewState extends State<PatientsDatabaseView> {
  http.Client client = http.Client();
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    _retrievePatients();
    super.setState(() {});
  }

  _retrievePatients() async {
    patients = [];
    List response = json.decode(
        (await client.get(Uri.http('127.0.0.1:8000', 'patients'))).body);
    for (var element in response) {
      patients.add(Patient.fromJson(element));
    }
    patientsFiltered = patients;
    setState(() {});
  }

  List<Patient> patientsFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: backgroundColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: backgroundColor, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          )),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value.toLowerCase();
                        patientsFiltered = patients
                            .where((patient) =>
                                patient.pesel
                                    .toString()
                                    .toLowerCase()
                                    .contains(_searchResult) ||
                                [
                                  patient.name.toLowerCase(),
                                  patient.surname.toLowerCase()
                                ].join(' ').contains(_searchResult) ||
                                [
                                  patient.surname.toLowerCase(),
                                  patient.name.toLowerCase()
                                ].join(' ').contains(_searchResult))
                            .toList();
                      });
                    }),
              ),
            ),
            const AddPatientButton(),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Expanded(
            child: Column(children: [
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: const [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'surname',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'pesel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: patientsFiltered.length,
              itemBuilder: ((BuildContext context, index) {
                return Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            patientsFiltered[index].name,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: Text(
                            patientsFiltered[index].surname,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: Text(
                            patientsFiltered[index].pesel,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      widget.updatePesel(patientsFiltered[index].pesel);
                    },
                    hoverColor: Colors.black.withOpacity(0.1),
                  ),
                );
              }),
            ),
          ),
        ]))
      ],
    );
  }
}
