import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HttpClientImpl implements IHttpClient {
  final Client _httpClient;

  HttpClientImpl({required Client httpClient}) : _httpClient = httpClient;

  @override
  Future<HttpClientResponse<String>> get(String path,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    final url = Uri.parse(path);

    final response = await _httpClient.get(url, headers: headers);

    if ([200, 201, 202, 204].contains(response.statusCode)) {
      return HttpClientResponse(
        data: utf8.decode(response.bodyBytes),
        statusCode: response.statusCode,
      );
    }

    throw Exception(response.body);
  }

  @override
  Future<HttpClientResponse<Uint8List>> getBytecode(String path,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    final url = Uri.parse(path);

    final response = await _httpClient.get(url, headers: headers);

    if ([200, 201, 202, 204].contains(response.statusCode)) {
      return HttpClientResponse(
        data: response.bodyBytes,
        statusCode: response.statusCode,
      );
    }

    throw Exception(response.body);
  }
}

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
