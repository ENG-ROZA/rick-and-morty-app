import 'package:flutter/material.dart';

import 'package:flutter_breakingbad/data/models/characters.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/strings.dart';

class Search extends SearchDelegate {
  final List<CharactersModel> charactersList;

  Search(this.charactersList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = charactersList.where((character) =>
        character.name?.toLowerCase().contains(query.toLowerCase()) ?? false
    ).toList();

    return results.isEmpty
        ? const Center(child: Text('No results found'))
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final character = results[index];
              return ListTile(
                leading: character.image != null
                    ? Image.network(character.image!, width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.image_not_supported),
                title: Text(character.name ?? 'No name'),
                onTap: () {
                  Navigator.pushNamed(context, charactersDetailsScreen,
                      arguments: character);
                },
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = charactersList.where((character) =>
        character.name?.toLowerCase().contains(query.toLowerCase()) ?? false
    ).toList();

    return suggestions.isEmpty
        ? const Center(child: Text('No suggestions'))
        : ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final character = suggestions[index];
              return ListTile(
                leading: character.image != null
                    ? Image.network(character.image!, width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.image_not_supported),
                title: Text(character.name ?? 'No name'),
                onTap: () {
                  Navigator.pushNamed(context, charactersDetailsScreen,
                      arguments: character);
                },
              );
            },
          );
  }
}