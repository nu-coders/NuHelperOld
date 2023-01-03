import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  String tableNo;
  List<dynamic> table;
  TableCard({super.key, required this.tableNo, required this.table});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      margin: const EdgeInsets.all(10),
      height: 45,
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
                  "Table: $tableNo",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Table $tableNo'),
                          content: SizedBox(
                            width: 250,
                            height: 400,
                            child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount: table.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text((index + 1).toString() +
                                      ' - ' +
                                      table[index]['courseId'] +
                                      ' / ' +
                                      table[index]['section'] +
                                      ' / ' +
                                      table[index]['courseType']),
                                      
                                );
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          )
        ],
      ),
    );
  }
}
