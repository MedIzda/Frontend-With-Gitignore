import 'package:flutter/material.dart';

import '../../constants.dart';
import '../shared_components/header.dart';
import 'patients_info.dart';
import 'patients_details.dart';

class PatientsView extends StatefulWidget {
  const PatientsView({
    super.key,
  });

  @override
  State<PatientsView> createState() => _PatientsViewState();
}

class _PatientsViewState extends State<PatientsView> {
  String? _pesel;

  void _updatePesel(String newPesel) {
    setState(() {
      _pesel = newPesel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(text: 'PatientsView'),
            const SizedBox(height: defaultPadding),
            PatientsViewContents(
              pesel: _pesel,
              updatePesel: _updatePesel,
            )
          ],
        ),
      ),
    );
  }
}

class PatientsViewContents extends StatelessWidget {
  const PatientsViewContents(
      {super.key, @required this.pesel, required this.updatePesel});

  final String? pesel;
  final Function(String) updatePesel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: PatientDetails(pesel: pesel),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          flex: 5,
          child: PatientInfo(updatePesel: updatePesel),
        )
      ],
    );
  }
}
