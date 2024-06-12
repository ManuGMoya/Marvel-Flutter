import 'package:marvel_flutter/models/character.dart';

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

  Future<ComicsResponse> getComicsByCharacterId(
      int characterId, int offset, int limit) async {
    final response =
        await apiService.getComicsByCharacterId(characterId, offset, limit);
    return response;
  }
}
