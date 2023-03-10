import 'package:flutter/material.dart';
import 'package:medizda/pages/authentication/log_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.black, canvasColor: Colors.black),
      home: const LogInPage(),
    );
  }
}
