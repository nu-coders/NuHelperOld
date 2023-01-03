import 'package:flutter/material.dart';

class TableCard extends StatefulWidget {
  Map<String, dynamic> table;
  TableCard({super.key, required this.table});

  @override
  State<TableCard> createState() => _TableCardState(table);
}

class _TableCardState extends State<TableCard> {
  Map<String, dynamic> table;

  _TableCardState(this.table);
  @override
  void initState() {
    print("pp");
    print(table);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "Course: ${table['courseId']}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Type: ${table['courseType']}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Instructor: ${table['instructors'][0]['fullName']}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Section: ${table['section']}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
