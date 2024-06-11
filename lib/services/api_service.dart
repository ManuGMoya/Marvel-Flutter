import 'dart:convert';

import 'package:dio/dio.dart';

import 'marvel_interceptor.dart';

class ApiService {
  final String baseUrl = 'https://gateway.marvel.com/';
  Dio dio = Dio();

  ApiService(this.dio) {
    dio.interceptors.add(MarvelInterceptor());
    dio.transformer = _MyTransformer();
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

  Future<dynamic> getComicsByCharacterId(int characterId) async {
    final response =
        await dio.get('$baseUrl/v1/public/characters/$characterId/comics');
    var results = _processResponse(response);

    // Comprueba si los resultados son null
    if (results == null) {
      // Si los resultados son null, devuelve una lista vacía
      return [];
    } else if (results is List<dynamic>) {
      // Si los resultados son una lista, devuelve la lista tal cual
      return results;
    } else {
      throw Exception('Expected a list but got ${results.runtimeType}');
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

class _MyTransformer extends DefaultTransformer {
  _MyTransformer() : super(jsonDecodeCallback: parseJson);

  @override
  Future<String> transformRequest(RequestOptions options) {
    print('Request: ${options.data}');
    return super.transformRequest(options);
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody responseBody) {
    print('Response: ${responseBody.toString()}');
    return super.transformResponse(options, responseBody);
  }

  static dynamic parseJson(String text) {
    return jsonDecode(text);
  }
}
