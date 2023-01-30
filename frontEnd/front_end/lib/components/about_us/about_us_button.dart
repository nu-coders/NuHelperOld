import 'package:flutter/material.dart';

class AboutUsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback pressFunction;
  const AboutUsButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.pressFunction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: (pressFunction),
        style: const ButtonStyle(
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Icon(
                color: Colors.lightBlue[500],
                icon,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text,
                style: const TextStyle(color: Color.fromARGB(255, 6, 115, 179)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
