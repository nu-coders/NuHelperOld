import 'package:flutter/material.dart';

class TableMakerResult extends StatefulWidget {
  List<dynamic> table;
  TableMakerResult(this.table, {super.key});

  @override
  State<TableMakerResult> createState() => _TableMakerResultState(table);
}

class _TableMakerResultState extends State<TableMakerResult> {
  List<dynamic> table;
  List<String> tables = [];
  String dropdownValue = "Table: 1";
  int tableIndex = 0;
  _TableMakerResultState(this.table);
  List<String> daysName = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  @override
  void initState() {
    tables =
        List<String>.generate(table.length, (index) => "Table: ${index + 1}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Color.fromARGB(255, 9, 111, 206)),
            underline: Container(
              height: 2,
              color: Color.fromARGB(255, 106, 183, 255),
            ),
            onChanged: (String? value) {
              dropdownValue = value!;
              tableIndex = int.parse(value.split(': ')[1]) - 1;
              setState(() {});
            },
            items: tables.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: table[tableIndex].length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  // height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 106, 183, 255)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Course: ${table[tableIndex][index]['courseId']}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Type: ${table[tableIndex][index]['courseType']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Instructor: ${table[tableIndex][index]['instructors'][0]['fullName']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Section: ${table[tableIndex][index]['section']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "CreditsHours: ${table[tableIndex][index]['credits']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Time: ${table[tableIndex][index]['schedule'][0]["startTime"]} - ${table[tableIndex][index]['schedule'][0]["endTime"]}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Room: ${table[tableIndex][index]['schedule'][0]["roomId"]}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Day: ${daysName[table[tableIndex][index]['schedule'][0]['scheduledDays'][0]]}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
