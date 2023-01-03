import 'package:flutter/material.dart';
import 'package:front_end/backend/shared_variables.dart';
import 'package:get/get.dart';

class TableMakerSlider extends StatefulWidget {
  const TableMakerSlider({super.key});

  @override
  State<TableMakerSlider> createState() => _TableMakerSliderState();
}

class _TableMakerSliderState extends State<TableMakerSlider> {
  double atendDays = 1;
  @override
  Widget build(BuildContext context) {
    final SharedVariables variables = Get.put(SharedVariables());
    return SizedBox(
      width: 300,
      child: Theme(
        data: ThemeData(backgroundColor: Colors.transparent),
        child: Slider(
          value: atendDays,
          max: 6,
          min: 1,
          divisions: 5,
          label: 'Days: ${atendDays.toInt()}',
          onChanged: ((value) {
            setState(() {
              variables.attendDays.value = value.toInt();
              atendDays = value;
            });
            print(value.toInt());
          }),
        ),
      ),
    );
  }
}
