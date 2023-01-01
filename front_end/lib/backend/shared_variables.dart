import 'package:get/get.dart';

class SharedVariables extends GetxController {
  Set<String> coursesCart = <String>{}.obs;
  List<String> coursesSuggestions = [
    "CSCI311",
    'CSCI201',
    'MATH-301',
    "MATH-111",
    "ENGL-201",
    "ENGL-101"
  ].obs;
  List<String> roomsSuggestions = ["F37", 'S44', '054', "9", "132", "138"].obs;
  List<List<String>> rooms = [
    ["f31", "csci322", "occ"],
    ["f32", "csci324", "occ"],
    ["f33", "csci323", "occ"],
    ["f34", "csci325", "occ"],
    ["f37", "free", "free"],
  ].obs;
  void addCourse(String course) {
    coursesCart.add(course);
  }

  void removeCourse(String course) {
    coursesCart.remove(course);
  }

  void clearCourses() {
    coursesCart.clear();
  }
}
