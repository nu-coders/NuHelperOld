import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        title: (Text("chill")),
      ),
    );
  }
}
