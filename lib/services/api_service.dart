import 'package:dio/dio.dart';

import '../models/comic.dart';
import 'marvel_interceptor.dart';

class ApiService {
  final String baseUrl = 'https://gateway.marvel.com/';
  Dio dio = Dio();

  ApiService(this.dio) {
    dio.interceptors.add(MarvelInterceptor());
  }

  Future<dynamic> getAllCharacters(int offset, int limit) async {
    final response = await dio.get('$baseUrl/v1/public/characters',
        queryParameters: {'offset': offset, 'limit': limit});
    return _processResponse(response);
  }

  Future<dynamic> getCharacterById(int characterId) async {
    final response =
        await dio.get('$baseUrl/v1/public/characters/$characterId');
    var results = _processResponse(response);

    // Comprueba si los datos son una lista
    if (results is List<dynamic>) {
      // Si es una lista, toma el primer elemento
      return results[0];
    } else {
      throw Exception('Expected a list but got ${results.runtimeType}');
    }
  }

  Future<dynamic> getCharacterByStartName(
      int offset, int limit, String nameStartsWith) async {
    final response = await dio.get('$baseUrl/v1/public/characters',
        queryParameters: {
          'offset': offset,
          'limit': limit,
          'nameStartsWith': nameStartsWith
        });
    return _processResponse(response);
  }

  Future<ComicsResponse> getComicsByCharacterId(
      int characterId, int offset, int limit) async {
    final response = await dio.get(
        '$baseUrl/v1/public/characters/$characterId/comics',
        queryParameters: {'offset': offset, 'limit': limit});
    if (response.statusCode == 200) {
      var decodedResponse = response.data;
      var data = decodedResponse['data'];
      var results = data['results'];
      var total = data['total'].toInt();
      final comics = (results as List)
          .map((json) => Comic.fromJson(json as Map<String, dynamic>))
          .toList();
      return ComicsResponse(comics: comics, total: total);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  dynamic _processResponse(Response response) {
    if (response.statusCode == 200) {
      var decodedResponse = response.data;
      var data = decodedResponse['data'];
      var results = data['results'];
      return results;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}

class ComicsResponse {
  final List<Comic> comics;
  final int total;

  ComicsResponse({required this.comics, required this.total});
}
