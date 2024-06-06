import 'package:dio/dio.dart';

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
    return _processResponse(response);
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
