import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        // appBar: AppBar(title: Text("hellop")),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset("assets/images/logo.png", width: 200)
          ],
        )),
      ),
    );
  }
}
