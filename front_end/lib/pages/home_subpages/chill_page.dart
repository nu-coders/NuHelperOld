import 'package:flutter/material.dart';

class ChillPage extends StatefulWidget {
  const ChillPage({super.key});

  @override
  State<ChillPage> createState() => _ChillPageState();
}

class _ChillPageState extends State<ChillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text("chill")),
      ),
    );
  }
}
