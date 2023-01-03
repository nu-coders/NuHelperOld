import 'package:get/get.dart';

class SharedVariables extends GetxController {
  Set<String> coursesCart = <String>{}.obs;
  var attendDays = 1.obs;
  Set<String> selectedDays = <String>{}.obs;
  List<dynamic> coursesSuggestions = [].obs;

  var roomLocatorFilter = 3.obs;
  Map<String, dynamic> rooms = <String, dynamic>{}.obs;
  List<dynamic> roomsSuggestions = [].obs;

  void addCourse(String course) {
    coursesCart.add(course);
  }

  void removeCourse(String course) {
    coursesCart.remove(course);
  }

  void clearCourses() {
    coursesCart.clear();
  }

  void updateSelectedDays(Set<String> input) {
    selectedDays = input;
  }

  void resetTableMaker() {
    selectedDays.clear();
    coursesCart.clear();
    attendDays.value = 1;
  }
}
