import 'package:flutter/material.dart';
import 'package:medizda/pages/authentication/log_in.dart';
import 'package:medizda/pages/home/home_page.dart';

import '../../constants.dart';
import '../patients/patients_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.local_drink,
                    color: Colors.black,
                  ),
                  SizedBox(width: defaultPadding / 2),
                  Text(
                    'A M A R E N A',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
            ),
            DrawerListTile(
              text: 'H O M E',
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            const ClinicSelectionExpansion(),
            DrawerListTile(
              text: 'P A T I E N T S',
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PatientsPage()),
                );
              },
            ),
            DrawerListTile(
              text: 'S E R V I C E S',
              icon: const Icon(Icons.attach_money, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PatientsPage()),
                );
              },
            ),
            DrawerListTile(
              text: 'S E T T I N G S',
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {},
            ),
            DrawerListTile(
              text: 'S I G N   O U T',
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback onPressed;

  const DrawerListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        horizontalTitleGap: 0.0,
        onTap: onPressed,
        leading: icon,
        title: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}

class ClinicSelectionExpansion extends StatefulWidget {
  const ClinicSelectionExpansion({super.key});

  @override
  State<ClinicSelectionExpansion> createState() =>
      _ClinicSelectionExpansionState();
}

class _ClinicSelectionExpansionState extends State<ClinicSelectionExpansion> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            expanded = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const ListTile(
                horizontalTitleGap: 0.0,
                title:
                    Text('C L I N I C', style: TextStyle(color: Colors.black)),
                leading: Icon(Icons.local_hospital, color: Colors.black),
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 0.0,
                    title: const Text('CLINIC 1',
                        style: TextStyle(color: Colors.black)),
                    leading: const Icon(Icons.healing, color: Colors.black),
                    onTap: () {},
                  ),
                  ListTile(
                    horizontalTitleGap: 0.0,
                    title: const Text('CLINIC 2',
                        style: TextStyle(color: Colors.black)),
                    leading: const Icon(Icons.healing, color: Colors.black),
                    onTap: () {},
                  ),
                  ListTile(
                    horizontalTitleGap: 0.0,
                    title: const Text('ADD CLINIC',
                        style: TextStyle(color: Colors.black)),
                    leading: const Icon(Icons.add, color: Colors.black),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            isExpanded: expanded,
            canTapOnHeader: true,
          )
        ]);
  }
}
