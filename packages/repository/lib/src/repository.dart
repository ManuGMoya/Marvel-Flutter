import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/models/comics_response.dart';

/// A repository class for handling operations related to Marvel characters.
class CharacterRepository {
  /// Creates a new instance of [CharacterRepository].
  ///
  /// The [baseUrl] and [apiClient] are optional. If not provided,
  /// a default [ApiClient] with the Marvel base URL and a [Dio] instance
  /// will be used.
  CharacterRepository({
    String? baseUrl,
    ApiClient? apiClient,
  }) : _apiClient = apiClient ??
            ApiClient(
              dio: Dio(
                BaseOptions(
                  baseUrl: baseUrl ?? 'https://gateway.marvel.com/',
                ),
              ),
              interceptors: [
                MarvelInterceptor(),
                LoggingInterceptor(logEnabled: true),
              ],
            );

  final ApiClient _apiClient;

  /// Fetches a list of characters from the Marvel API.
  ///
  /// The [offset] and [limit] parameters are used for pagination.
  Future<List<Character>> getAllCharacters(int offset, int limit) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      'v1/public/characters',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    if (response is Map<String, dynamic>) {
      return _processResponse(response);
    } else {
      throw Exception('Expected a Map but got ${response.runtimeType}');
    }
  }

  /// Fetches a single character by its ID from the Marvel API.
  Future<Character> getCharacterById(int characterId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      'v1/public/characters/$characterId',
    );

    if (response is Map<String, dynamic>) {
      final characters = _processResponse(response);
      return characters.first;
    } else {
      throw Exception('Expected a Map but got ${response.runtimeType}');
    }
  }

  /// Fetches a list of characters whose names start with the provided string.
  ///
  /// The [offset] and [limit] parameters are used for pagination.
  /// The [nameStartsWith] parameter is used to filter characters by name.
  Future<List<Character>> getCharacterByStartName(
    int offset,
    int limit,
    String nameStartsWith,
  ) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      'v1/public/characters',
      queryParameters: {
        'offset': offset,
        'limit': limit,
        'nameStartsWith': nameStartsWith,
      },
    );

    if (response is Map<String, dynamic>) {
      return _processResponse(response);
    } else {
      throw Exception('Expected a Map but got ${response.runtimeType}');
    }
  }

  /// Fetches a list of comics by a character's ID from the Marvel API.
  ///
  /// The [characterId] parameter is the ID of the character.
  /// The [offset] and [limit] parameters are used for pagination.
  Future<ComicsResponse> getComicsByCharacterId(
    int characterId,
    int offset,
    int limit,
  ) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      'v1/public/characters/$characterId/comics',
      queryParameters: {'offset': offset, 'limit': limit},
    );

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

  /// Processes the response from the Marvel API and returns a list
  /// of characters.
  ///
  /// The [response] parameter is the response from the Marvel API.
  List<Character> _processResponse(Map<String, dynamic> response) {
    final data = response['data'] as Map<String, dynamic>;
    final results = data['results'] as List;
    return results
        .map((json) => Character.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
