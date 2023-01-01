import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomLocator {
  Future<List> getRooms(int building) async {
    var url =
        Uri.parse("http://192.168.3.9:8085/api/getrooms/?building=$building");
    var response = await http.get(url);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getRoom(String id) async {
    var url = Uri.parse("http://127.0.0.1:8085/api/getroom/?id=$id");
    var response = await http.get(url);

    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> whatsin(String id) async {
    var url = Uri.parse("http://127.0.0.1:8085/api/whatsin/?id=$id");
    var response = await http.get(url);

    return Map<String, dynamic>.from(jsonDecode(response.body));
  }

  Future<String> api(String id) async {
    var url = Uri.parse("http://127.0.0.1:8085/api/whatsin/?id=$id");
    var response = await http.get(url);
    return response.body;
  }
}

void main(List<String> args) {
  RoomLocator i = RoomLocator();
  i.getRooms(1).then((value) => print(value.length));
}
