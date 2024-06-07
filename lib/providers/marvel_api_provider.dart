import 'package:flutter/cupertino.dart';

import '../models/character.dart';
import '../repositories/character_repository.dart';

class MarvelApiProvider with ChangeNotifier {
  List<Character> _characters = [];
  final CharacterRepository characterRepository;

  MarvelApiProvider({required this.characterRepository});

  List<Character> get characters => _characters;

  Future<void> fetchCharacters(int start, int count) async {
    List<Character> newCharacters =
        await characterRepository.getAllCharacters(start, count);
    _characters.addAll(newCharacters);
    notifyListeners();
  }
}
