import 'package:flutter/material.dart';

class TableMakerPage extends StatefulWidget {
  const TableMakerPage({super.key});

  @override
  State<TableMakerPage> createState() => _TableMakerPageState();
}

class _TableMakerPageState extends State<TableMakerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Maker"),
      ),
    );
  }
}
