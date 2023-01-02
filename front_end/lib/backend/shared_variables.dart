import 'package:get/get.dart';

class SharedVariables extends GetxController {
  Set<String> coursesCart = <String>{}.obs;
  var attendDays = 0.obs;
  Set<int> selectedDays = <int>{}.obs;
  var roomLocatorFilter = 3.obs;
  List<String> coursesSuggestions = [
    "CSCI311",
    'CSCI201',
    'MATH-301',
    "MATH-111",
    "ENGL-201",
    "ENGL-101"
  ].obs;

  Map<String, dynamic> rooms = <String, dynamic>{}.obs;
  List<dynamic> roomsSuggestions = ["F37", 'S44', '054', "9", "132", "138"].obs;

  void addCourse(String course) {
    coursesCart.add(course);
  }

  void removeCourse(String course) {
    coursesCart.remove(course);
  }

  void clearCourses() {
    coursesCart.clear();
  }

  void updateSelectedDays(Set<int> input) {
    selectedDays = input;
  }
}
