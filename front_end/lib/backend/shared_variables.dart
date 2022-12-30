import 'package:get/get.dart';

class SharedVariables extends GetxController {
  List<dynamic> roomsz = [].obs;
  Set<String> courses = {"a", 'b', 'c', 'd'}.obs;

  void addCourse(String course) {
    courses.add(course);
  }

  void removeCourse(String course) {
    courses.remove(course);
  }

  var test = 0.obs;
  void add(List<dynamic> list) {
    roomsz = list;
  }

  void clearCourses() {
    courses.clear();
  }
}
