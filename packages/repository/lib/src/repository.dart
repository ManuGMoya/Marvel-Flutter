import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:repository/repository.dart';

import 'models/comics_response.dart';

class CharacterRepository {
  CharacterRepository({
    ApiService? apiService,
  }) : _apiService = apiService ??
            ApiService(
              Dio(),
            );

  final ApiService _apiService;

  /// Fetches a list of characters
  Future<List<Character>> getAllCharacters(int offset, int limit) async {
    final data = await _apiService.getAllCharacters(offset, limit);
    final characters = <Character>[];

    if (data is List) {
      for (final result in data) {
        characters.add(Character.fromJson(result as Map<String, dynamic>));
      }
    } else {
      throw Exception('Expected a list but got ${data.runtimeType}');
    }

    return characters;
  }

  Future<Character> getCharacterById(int characterId) async {
    final data = await _apiService.getCharacterById(characterId);
    return Character.fromJson(data as Map<String, dynamic>);
  }

  Future<List<Character>> getCharacterByStartName(
      int offset, int limit, String nameStartsWith,) async {
    final data = await _apiService.getCharacterByStartName(
        offset, limit, nameStartsWith);
    final characters = <Character>[];

    if (data is List) {
      for (final result in data) {
        characters.add(Character.fromJson(result as Map<String, dynamic>));
      }
    } else {
      throw Exception('Expected a list but got ${data.runtimeType}');
    }

    return characters;
  }

  Future<ComicsResponse> getComicsByCharacterId(
      int characterId, int offset, int limit,) async {
    final response =
        await _apiService.getComicsByCharacterId(characterId, offset, limit);

    if (response is Map<String, dynamic>) {
      final data = response['data'] as Map<String, dynamic>;
      final results = data['results'] as List;
      final total = data['total'] as int;
      final comics = results
          .map((json) => Comic.fromJson(json as Map<String, dynamic>))
          .toList();

      return ComicsResponse(comics: comics, total: total);
    } else {
      throw Exception('Expected a Map but got ${response.runtimeType}');
    }
  }
}
