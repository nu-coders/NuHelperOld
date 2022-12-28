import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoomLocatorPage extends StatefulWidget {
  const RoomLocatorPage({super.key});

  @override
  State<RoomLocatorPage> createState() => RoomLocatorPageState();
}

class RoomLocatorPageState extends State<RoomLocatorPage> {
  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];
  String searchValue = 'temp';
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
                delegate: SearchBar(),
              );
            },
          )
        ],
        title: (const Text("roomlocator")),
      ),
    );

    // return const Center(
    //   child: Text("RoomLocatorPage"),
    // );
  }
}

class SearchBar extends SearchDelegate {
  List<String> sug1 = ["hello", "world", "wir", "potato"];

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
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
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
              showResults(context);
            },
          );
        }),
        itemCount: sug.length);
  }
}
