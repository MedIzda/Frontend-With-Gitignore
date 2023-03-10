import 'package:flutter/material.dart';
import 'package:medizda/pages/shared_components/side_bar.dart';

import 'patients_view.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: SideBar(),
          ),
          Expanded(
            flex: 5,
            child: PatientsView(),
          )
        ],
      )),
    );
  }
}
