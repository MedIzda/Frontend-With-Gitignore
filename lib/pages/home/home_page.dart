import 'package:flutter/material.dart';
import 'package:medizda/pages/shared_components/side_bar.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            child: HomeView(),
          )
        ],
      )),
    );
  }
}
