import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/shared_variables.dart';

class CoursesCart extends StatefulWidget {
  const CoursesCart({super.key});

  @override
  State<CoursesCart> createState() => _CoursesCartState();
}

class _CoursesCartState extends State<CoursesCart> {
  final SharedVariables variables = Get.put(SharedVariables());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('In Your Cart'),
      content: SizedBox(
        width: 300,
        height: 200,
        child: ListView.builder(
          itemCount: variables.courses.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () {
                    String course = variables.courses.elementAt(index);
                    setState(() {
                      variables.removeCourse(course);
                    });
                  },
                  child: Text(variables.courses.elementAt(index)),
                ),
              ),
            );
          }),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            variables.clearCourses();
            return Navigator.pop(context);
          },
          child: const Text('Clear'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
