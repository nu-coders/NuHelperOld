import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:front_end/backend/room_locator.dart';

import '../loading_page.dart';

class RoomLocatorPage extends StatefulWidget {
  const RoomLocatorPage({super.key});

  @override
  State<RoomLocatorPage> createState() => RoomLocatorPageState();
}

class RoomLocatorPageState extends State<RoomLocatorPage> {
  List<dynamic> rooms = [];
  RoomLocator backend = RoomLocator();
  var loaded = false;
  @override
  void initState() {
    print(rooms);
    backend.getRooms(1).then((value) {
      setState(() {
        rooms = value;
        loaded = true;
        print("object000000000000000000");
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !loaded
        ? IntroPage()
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchBar(),
                    );
                  },
                )
              ],
              title: (Text("roomlocator")),
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

class SearchBar extends SearchDelegate {
  List<String> sug1 = ["hello", "world", "wir", "potato"];
  SearchBar();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            }
            query = '';
          },
          icon: Icon(Icons.clear)),
      IconButton(onPressed: () {}, icon: Icon(Icons.menu))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> sug = sug1.where((res) {
      final result = res.toLowerCase();
      final inp = query.toLowerCase();
      return result.contains(inp);
    }).toList();

    return ListView.builder(
        itemBuilder: ((context, index) {
          final sugg = sug[index];
          return ListTile(
            title: Text(sugg),
            onTap: () {
              query = sugg;
              close(context, query);
            },
          );
        }),
        itemCount: sug.length);
  }
}
