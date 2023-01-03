import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/shared_variables.dart';

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
      title: const Text('Courses Cart'),
      content: SizedBox(
        width: 300,
        height: 200,
        child: variables.coursesCart.isEmpty
            ? const Center(
                child: Text("Your Cart is Empty :)"),
              )
            : ListView.builder(
                itemCount: variables.coursesCart.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: const ButtonStyle(
                          alignment: Alignment.centerLeft,
                          textStyle: MaterialStatePropertyAll<TextStyle?>(
                            TextStyle(fontSize: 16),
                          ),
                        ),
                        onPressed: () {
                          String course =
                              variables.coursesCart.elementAt(index);
                          setState(() {
                            variables.removeCourse(course);
                          });
                        },
                        child: Text(variables.coursesCart.elementAt(index)),
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
