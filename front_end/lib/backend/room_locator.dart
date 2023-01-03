import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomLocator {
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

  Future<String> getRoom(String id) async {
    var url = Uri.parse("http://192.168.3.9:8080/api/getroom/?id=$id");
    var response = await http.get(url);
    if (response.statusCode == 404) {
      return '404';
    } else if (response.statusCode == 405) {
      return '405';
    }
    return response.body;
  }

  Future<List<dynamic>> getSug() async {
    var url = Uri.parse("http://192.168.3.9:8080/api/suglist/");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}

// void main(List<String> args) {
//   RoomLocator i = RoomLocator();

//   i.getRoom('233').then((value) => print(jsonDecode(value).runtimeType));
//   // i.getRooms(3).then((value) {
//   //   print(value.length);ó
//   //   Map<String, dynamic> j = jsonDecode(value);
//   //   print(j.keys.elementAt(1));
//   //   // for (var element in j) {
//   //   //   print(element);
//   //   // }
//   // });
// }

// int test(Map<String, dynamic> jsonInput) {
//   return 0;
// }
