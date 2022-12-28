import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TableMakerPage extends StatefulWidget {
  const TableMakerPage({super.key});

  @override
  State<TableMakerPage> createState() => _TableMakerPageState();
}

class _TableMakerPageState extends State<TableMakerPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("TableMakerPage"),
    );
  }
}
