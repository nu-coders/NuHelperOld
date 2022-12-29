import 'package:get/get.dart';

class SharedVariables extends GetxController {
  List<dynamic> roomsz = [].obs;
  var test = 0.obs;
  void add(List<dynamic> list) {
    roomsz = list;
  }
}
