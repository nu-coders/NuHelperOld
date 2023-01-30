import 'package:http/http.dart' as http;
import 'dart:convert';

class TableMaker {
  Future<String> getRooms(int building) async {
    var url =
        Uri.parse("http://192.168.3.9:8080/api/getrooms/?building=$building");
    var response = await http.get(url);
    if (response.statusCode == 404) {
      return '404';
    } else if (response.statusCode == 405) {
      return '405';
    }
    return response.body;
  }

  Future<String> createTable(
      List<String> courses, int attendDays, List<String> selectedDays) async {
    var response =
        await http.post(Uri.parse('http://192.168.3.9:8080/createTableNoClash'),
            body: jsonEncode(
              {
                "id": courses,
                "useFilters": true,
                "filters": {"noDays": attendDays, "DaysToGo": selectedDays}
              },
            ),
            headers: {'Content-Type': 'application/json'},
            encoding: Encoding.getByName("utf-8"));
    return response.body;
  }

  Future<List<dynamic>> getSug() async {
    var url = Uri.parse("http://192.168.3.9:8080/getAllCourseNames");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}

void main(List<String> args) {
  TableMaker t = TableMaker();
  t
      .createTable(["AIS301", "CSCI311"], 4,
          ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"])
      .then((value) => print(jsonDecode(value).runtimeType));
}
