import 'package:flutter/material.dart';
import 'package:front_end/components/rl/room_card.dart';

class SearchBar extends SearchDelegate {
  List<String> suggestions;
  Set<String> set = {};
  SearchBar(this.suggestions);

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
      IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
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
    return RoomCard(course: "course", room: query, status: "status");
    // child: Text("This a serious bug please report\nthx, Devs"),
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestion = suggestions.where((res) {
      final result = res.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemBuilder: ((context, index) {
          final sugg = suggestion[index];
          return ListTile(
            title: Text(sugg),
            onTap: () {
              query = sugg;
              showResults(context);
            },
          );
        }),
        itemCount: suggestion.length);
  }
}
