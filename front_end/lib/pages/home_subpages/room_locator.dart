import 'package:flutter/material.dart';
import 'package:front_end/backend/room_locator.dart';
import 'package:front_end/backend/shared_variables.dart';
import 'package:get/get.dart';

import '../../components/search_bar.dart';

class RoomLocatorPage extends StatefulWidget {
  const RoomLocatorPage({super.key});

  @override
  State<RoomLocatorPage> createState() => RoomLocatorPageState();
}

class RoomLocatorPageState extends State<RoomLocatorPage> {
  List<dynamic> rooms = [];
  final SharedVariables abc = Get.put(SharedVariables());

  RoomLocator backend = RoomLocator();
  var loaded = false;
  @override
  // void initState() {
  //   print(abc.roomsz);
  //   // backend.getRooms(1).then((value) {
  //     setState(() {
  //       abc.add(value);
  //       rooms = value;
  //       loaded = true;
  //       // print("object000000000000000000");
  //     });
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBar(
                    ["hello", 'Mario', 'sus', "world", "wir", "potato"]),
              );
            },
          )
        ],
        title: (const Text("Room Locator")),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${rooms[index]}'),
          );
        },
      ),
    );

    // return const Center(
    //   child: Text("RoomLocatorPage"),
    // );
  }
}
