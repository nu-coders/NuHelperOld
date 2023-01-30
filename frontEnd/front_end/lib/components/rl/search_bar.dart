import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/components/rl/search_card.dart';

import '../../backend/room_locator.dart';

String searchQuery = "";

class SearchBarRM extends SearchDelegate {
  List<dynamic> suggestions;
  Set<String> set = {};

  SearchBarRM(this.suggestions);

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
          icon: const Icon(Icons.clear)),
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
    searchQuery = query;
    return const SearchReasult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> suggestion = suggestions.where((res) {
      final result = res.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemBuilder: ((context, index) {
          final sugg = suggestion[index];
          return ListTile(
            title: Text(sugg),
            onTap: () async {
              searchQuery = query = sugg;
              showResults(context);
            },
          );
        }),
        itemCount: suggestion.length);
  }
}

class SearchReasult extends StatefulWidget {
  const SearchReasult({super.key});

  @override
  State<SearchReasult> createState() => _SearchReasultState();
}

class _SearchReasultState extends State<SearchReasult> {
  String query = searchQuery;

  bool loading = true;
  bool outsideSlot = false;
  bool error = false;
  Map<String, dynamic> json = {};

  _SearchReasultState();
  RoomLocator backend = RoomLocator();

  void backendCall() async {
    error = outsideSlot = false;
    String response = await backend.getRoom(query);
    print(response);
    if (response == "404") {
      error = true;
    } else if (response == "405") {
      outsideSlot = true;
    } else {
      json = jsonDecode(response);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    backendCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : error
            ? const Center(
                child: Text(
                  "Not A Room :(",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : outsideSlot
                ? const Center(
                    child: Text(
                      "Not a working hour",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                : SearchCard(
                    course: json['course'] == 0 ? "None" : json['course'],
                    room: searchQuery.toString(),
                    status: json['status'] == true ? "Vacant" : "Occupied");
  }
}
