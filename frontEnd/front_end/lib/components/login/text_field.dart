import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
      child: TextField(
        focusNode: FocusNode(),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade200, width: 1.1),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 20, 137, 255), width: 1.1),
              borderRadius: BorderRadius.circular(6),
            ),
            hintText: hintText),
      ),
    );
  }
}
