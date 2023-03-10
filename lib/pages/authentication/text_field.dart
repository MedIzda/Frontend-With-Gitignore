import 'package:flutter/material.dart';
import 'package:medizda/constants.dart';

class AuthenticationTextField extends StatelessWidget {
  final String label;
  final bool isObscured;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  const AuthenticationTextField({
    super.key,
    required this.label,
    required this.isObscured,
    required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscured,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColor),
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: prefixIcon,
        //suffixIcon: suffixIcon,
      ),
    );
  }
}
