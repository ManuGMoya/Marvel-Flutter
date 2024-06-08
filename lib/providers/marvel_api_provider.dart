import 'package:flutter/cupertino.dart';

import '../models/character.dart';
import '../repositories/character_repository.dart';

class MarvelApiProvider with ChangeNotifier {
  final List<Character> _characters = [];
  final CharacterRepository characterRepository;

  bool _isLoadingMore = false;

  MarvelApiProvider({required this.characterRepository});

  List<Character> get characters => _characters;

  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchCharacters(int start, int count) async {
    _isLoadingMore = true;
    notifyListeners();

    List<Character> newCharacters =
        await characterRepository.getAllCharacters(start, count);
    _characters.addAll(newCharacters);

    _isLoadingMore = false;
    notifyListeners();
  }
}
