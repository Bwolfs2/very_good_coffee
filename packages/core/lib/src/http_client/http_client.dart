import 'package:flutter/foundation.dart';

abstract class IHttpClient {
  Future<HttpClientResponse<String>> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  });

  Future<HttpClientResponse<Uint8List>> getBytecode(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  });
}

class HttpClientResponse<T> {
  final T data;

  final int statusCode;

  final String? statusMessage;

  const HttpClientResponse({
    required this.data,
    required this.statusCode,
    this.statusMessage,
  });
}
