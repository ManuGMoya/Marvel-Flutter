import 'package:marvel_flutter/models/character.dart';

import '../models/comics.dart';
import '../services/api_service.dart';

class CharacterRepository {
  final ApiService apiService;

  CharacterRepository({required this.apiService});

  Future<List<Character>> getAllCharacters(int offset, int limit) async {
    final data = await apiService.getAllCharacters(offset, limit);
    return (data as List).map((json) => Character.fromJson(json)).toList();
  }

  Future<Character> getCharacterById(int characterId) async {
    final data = await apiService.getCharacterById(characterId);
    return Character.fromJson(data);
  }

  Future<List<Character>> getCharacterByStartName(
      int offset, int limit, String nameStartsWith) async {
    final data =
        await apiService.getCharacterByStartName(offset, limit, nameStartsWith);
    return (data as List).map((json) => Character.fromJson(json)).toList();
  }

  Future<List<Comics>> getComicsByCharacterId(int characterId) async {
    final data = await apiService.getComicsByCharacterId(characterId);
    return (data as List)
        .map((json) => Comics.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
