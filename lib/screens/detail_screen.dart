import 'package:flutter/material.dart';

import '../models/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name ?? '')),
      body: Column(
        children: <Widget>[
          Image.network(
            "${character.thumbnail?.path}"
            ".${character.thumbnail?.extension}",
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Text('No se pudo cargar la imagen');
            },
          ),
          Text(character.name ?? ''),
          Text(character.description ?? ''),
        ],
      ),
    );
  }
}
