import 'package:flutter/material.dart';
import 'package:front_end/backend/room_locator.dart';
import 'package:front_end/backend/shared_variables.dart';
import 'package:front_end/components/rl/room_card.dart';
import 'package:get/get.dart';

import '../../components/rl/room_cardV2.dart';
import '../../components/rl/search_bar.dart';

class RoomLocatorPage extends StatefulWidget {
  const RoomLocatorPage({super.key});

  @override
  State<RoomLocatorPage> createState() => RoomLocatorPageState();
}

class RoomLocatorPageState extends State<RoomLocatorPage> {
  final SharedVariables variables = Get.put(SharedVariables());

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
                delegate: SearchBar(variables.roomsSuggestions),
              );
            },
          )
        ],
        title: (const Text("Room Locator")),
      ),
      body: ListView.builder(
        itemCount: variables.rooms.length,
        itemBuilder: (context, index) {
          final room = variables.rooms[index];
          return ListTile(
            title: RoomCardV2(course: room[1], room: room[0], status: room[2]),
          );
        },
      ),
    );

    // return const Center(
    //   child: Text("RoomLocatorPage"),
    // );
  }
}
