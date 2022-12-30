import 'package:flutter/material.dart';
import 'package:front_end/components/tm/search_bar_tm.dart';
import 'package:get/get.dart';

import '../../backend/shared_variables.dart';
import '../../components/tm/cart.dart';

class TableMakerPage extends StatefulWidget {
  const TableMakerPage({super.key});

  @override
  State<TableMakerPage> createState() => _TableMakerPageState();
}

class _TableMakerPageState extends State<TableMakerPage> {
  final SharedVariables variables = Get.put(SharedVariables());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Maker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarTM(variables.coursesSuggestions),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => const CoursesCart()),
          ),
        ],
      ),
    );
  }
}
