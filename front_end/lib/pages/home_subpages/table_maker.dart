import 'package:flutter/material.dart';
import 'package:front_end/components/tm/days_list.dart';
import 'package:front_end/components/tm/search_bar_tm.dart';
import 'package:front_end/components/tm/slider.dart';
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
  double atendDays = 1;
  bool temp = false;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          const Text(
            "Days to attend:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          const TableMakerSlider(),
          const SizedBox(height: 300, child: DaysList()),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                if (variables.selectedDays.length !=
                    variables.attendDays.value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 2000),
                      content: Text(
                          "You selected ${variables.selectedDays.length} day/s and want to attend ${variables.attendDays.value} day/s HOW???"),
                    ),
                  );
                }
              },
              child: const Text("Create my Table"))
        ],
      ),
    );
  }
}
