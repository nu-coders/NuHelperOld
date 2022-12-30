import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/shared_variables.dart';

class SearchBarTM extends SearchDelegate {
  List<String> suggestions;
  final SharedVariables variables = Get.put(SharedVariables());


  SearchBarTM(this.suggestions);

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
      IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('In Your Cart'),
            content: SizedBox(
              width: 300,
              height: 200,
              child: ListView.builder(
                itemCount: variables.courses.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                        onPressed: () {
                          dynamic temp = variables.courses.elementAt(index);
                          // set.remove(temp);
                          print(temp);
                        },
                        child: Text(variables.courses.elementAt(index)),
                      ),
                    ),
                  );
                }),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Clear'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
        icon: const Icon(Icons.shopping_cart),
      )
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
    return const Center(
      child: Text("This a serious bug please report\nthx, Devs"),
    );
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
              print("object");
            },
          );
        }),
        itemCount: suggestion.length);
  }
}
