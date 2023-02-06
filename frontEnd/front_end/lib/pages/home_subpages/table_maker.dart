import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/components/tm/days_list.dart';
import 'package:front_end/components/tm/search_bar_tm.dart';
import 'package:front_end/components/tm/slider.dart';
import 'package:get/get.dart';

import '../../backend/shared_variables.dart';
import '../../backend/table_maker.dart';
import '../../components/tm/cart.dart';
import '../../components/tm/result.dart';

class TableMakerPage extends StatefulWidget {
  const TableMakerPage({super.key});

  @override
  State<TableMakerPage> createState() => _TableMakerPageState();
}

class _TableMakerPageState extends State<TableMakerPage> {
  final SharedVariables variables = Get.put(SharedVariables());
  double atendDays = 1;
  bool temp = false;
  TableMaker backend = TableMaker();
  bool loading = true;
  bool result = false;
  bool noTable = false;
  List<dynamic> table = [];
  void backendCall() async {
    // error = outsideSlot = false;
    variables.coursesSuggestions = await backend.getSug();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    backendCall();
    variables.resetTableMaker();

    super.initState();
  }

  @override
  void dispose() {
    variables.resetTableMaker();
    print("dissssssssss");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("Table Maker"),
              actions: result || noTable
                  ? []
                  : [
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
                            builder: (BuildContext context) =>
                                const CoursesCart()),
                      ),
                    ],
              leading: result || noTable
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          variables.resetTableMaker();
                          result = noTable = false;
                        });
                      },
                      icon: const Icon(Icons.arrow_back))
                  : null,
            ),
            body: noTable
                ? const Center(
                    child: Text(
                      "We can not create a table with these inputs :(\nTry again with different inputs :)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : result
                    ? TableMakerResult(table)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                          ),
                          const Text(
                            "Days to attend:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const TableMakerSlider(),
                          const SizedBox(height: 300, child: DaysList()),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                if (variables.selectedDays.length <
                                    variables.attendDays.value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 2500),
                                      content: Text(
                                          // "You selected ${variables.selectedDays.length} day/s and want to attend ${variables.attendDays.value} day/s HOW???"),
                                          "Attend days should be bigger than or equal Selected days ${variables.selectedDays.length} <= ${variables.attendDays.value} "),
                                    ),
                                  );
                                } else if (variables.coursesCart.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 2500),
                                      content: Text(
                                          // "How do you want to create a table without adding a single course to your cart? HOW???"),
                                          "Add at least a single course to your cart."),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );

                                  backend
                                      .createTable(
                                          variables.coursesCart.toList(),
                                          variables.attendDays.value,
                                          variables.selectedDays.toList())
                                      .then((value) {
                                    print(value);
                                    if (value == '[]') {
                                      noTable = true;
                                    } else {
                                      result = true;
                                      table = jsonDecode(value);
                                    }
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  });
                                }
                              },
                              child: const Text("Create my Table"))
                        ],
                      ),
          );
  }
}
