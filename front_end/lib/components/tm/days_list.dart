import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/shared_variables.dart';

class DaysList extends StatefulWidget {
  const DaysList({super.key});

  @override
  State<DaysList> createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  final SharedVariables variables = Get.put(SharedVariables());

  Set<int> days = {};

  List<String> daysName = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Saturday"
  ];
  List<bool> temp = List.filled(7, false);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        // bool temp = false;
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                checkColor: const Color.fromARGB(255, 255, 255, 255),
                fillColor: const MaterialStatePropertyAll(Colors.blueAccent),
                // value: temp,
                value: temp[index],
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null) {
                      temp[index] = value;
                      if (days.contains(index) && value == false) {
                        days.remove(index);
                      } else {
                        days.add(index);
                      }
                    }
                  });
                  variables.updateSelectedDays(days);
                  print(days.length);
                },
              ),
              Text(daysName[index]),
            ],
          ),
        );
      },
    );
  }
}
