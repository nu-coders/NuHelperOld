import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/backend/room_locator.dart';
import 'package:front_end/backend/shared_variables.dart';
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
  List<String> filterList = [
    "All",
    "Building 1",
    "Building 2",
  ];

  bool loading = true;
  bool outsideSlot = false;
  bool error = false;
  RoomLocator backend = RoomLocator();

  void backendCall() async {
    error = outsideSlot = false;
    String response = await backend.getRooms(variables.roomLocatorFilter.value);
    if (response == "404") {
      error = true;
    } else if (response == "405") {
      outsideSlot = true;
    } else {
      variables.rooms = jsonDecode(response);
    }

    variables.roomsSuggestions = await backend.getSug();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    print("loaded");
    backendCall();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
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
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.filter_alt),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 3,
                        child: Text(filterList[0]),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text(filterList[1]),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text(filterList[2]),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    setState(() {
                      variables.roomLocatorFilter.value = value;
                      backendCall();
                    });
                  },
                ),
              ],
              title: (const Text("Room Locator")),
            ),
            body: error
                ? const Center(
                    child: Text(
                      "Report this bug please :)",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                : outsideSlot
                    ? const Center(
                        child: Text(
                          "Not a working hour",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: variables.rooms.keys.length,
                        itemBuilder: (context, index) {
                          final room = variables.rooms.keys.elementAt(index);
                          final roomData = variables.rooms[room];
                          return ListTile(
                            title: RoomCardV2(
                                course: "None", room: room, status: "Vacant"),
                          );
                        },
                      ),
          );
  }
}
