import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyButton extends StatelessWidget {
  Color color;
  String text;
  VoidCallback  a;
  MyButton({
    super.key,
    required this.color,
    required this.text,
    required this.a
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: a,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            )),
      ),
    );
  }
}
