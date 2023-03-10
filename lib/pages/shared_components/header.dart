import 'package:flutter/material.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  final String text;
  const Header({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: defaultPadding),
      ],
    );
  }
}
