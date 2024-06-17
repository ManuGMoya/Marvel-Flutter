import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// `MarvelInterceptor` is a class that intercepts all requests made by Dio.
/// It adds the necessary Marvel API parameters to each request.
class MarvelInterceptor extends Interceptor {
  final String _privateKey = dotenv.env['MARVEL_PRIVATE_KEY']!;
  final String _publicKey = dotenv.env['MARVEL_PUBLIC_KEY']!;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateHash(ts, _privateKey, _publicKey);

    options.queryParameters.addAll({
      'apikey': _publicKey,
      'ts': ts,
      'hash': hash,
    });

    super.onRequest(options, handler);
  }

  String _generateHash(int time, String privateKey, String publicKey) {
    final bytes = utf8.encode('$time$privateKey$publicKey');
    return md5.convert(bytes).toString();
  }
}
