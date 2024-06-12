import 'package:dio/dio.dart';
import 'package:marvel_flutter/services/check_internet.dart';

import '../models/comic.dart';
import 'marvel_interceptor.dart';

class ApiService {
  final String baseUrl = 'https://gateway.marvel.com/';
  Dio dio = Dio();

  ApiService(this.dio) {
    dio.interceptors.add(MarvelInterceptor());
  }

  Future<dynamic> getAllCharacters(int offset, int limit) async {
    if (await CheckInternet.isConnected()) {
      final response = await dio.get('$baseUrl/v1/public/characters',
          queryParameters: {'offset': offset, 'limit': limit});
      return _processResponse(response);
    } else {
      throw Exception('Not Internet connection');
    }
  }

  Future<dynamic> getCharacterById(int characterId) async {
    if (await CheckInternet.isConnected()) {
      final response =
          await dio.get('$baseUrl/v1/public/characters/$characterId');
      var results = _processResponse(response);
      if (results is List<dynamic>) {
        return results[0];
      } else {
        throw Exception('Expected a list but got ${results.runtimeType}');
      }
    } else {
      throw Exception('Not Internet connection');
    }
  }

  Future<dynamic> getCharacterByStartName(
      int offset, int limit, String nameStartsWith) async {
    if (await CheckInternet.isConnected()) {
      final response = await dio.get('$baseUrl/v1/public/characters',
          queryParameters: {
            'offset': offset,
            'limit': limit,
            'nameStartsWith': nameStartsWith
          });
      return _processResponse(response);
    } else {
      throw Exception('Not Internet connection');
    }
  }

  Future<dynamic> getComicsByCharacterId(
      int characterId, int offset, int limit) async {
    if (await CheckInternet.isConnected()) {
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
    } else {
      throw Exception('Not Internet connection');
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
