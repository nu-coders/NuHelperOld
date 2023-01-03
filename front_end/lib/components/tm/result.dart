import 'package:flutter/material.dart';
import 'package:front_end/components/tm/table_card.dart';

class TableMakerResult extends StatelessWidget {
  List<dynamic> table;
  TableMakerResult(this.table, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: table.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: TableCard(
            tableNo: (index + 1).toString(),
            table: table[index],
          ));
        },
      ),
    );
  }
}
