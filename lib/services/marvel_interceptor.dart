import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarvelInterceptor extends Interceptor {
  final String privateKey = dotenv.env['MARVEL_PRIVATE_KEY']!;
  final String publicKey = dotenv.env['MARVEL_PUBLIC_KEY']!;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateHash(ts, privateKey, publicKey);

    options.queryParameters.addAll({
      'apikey': publicKey,
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
