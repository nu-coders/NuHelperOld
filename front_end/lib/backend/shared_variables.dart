import 'package:get/get.dart';

class SharedVariables extends GetxController {
  Set<String> courses = {"a", 'b', 'c', 'd'}.obs;
  List<String> coursesSuggestions =
      ["hello", 'Mario', 'sus', "world", "wir", "potato"].obs;

  void addCourse(String course) {
    courses.add(course);
  }

  void removeCourse(String course) {
    courses.remove(course);
  }

  void clearCourses() {
    courses.clear();
  }
}
