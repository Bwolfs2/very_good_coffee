import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'http_client.dart';

class HttpClientImpl implements IHttpClient {
  late final Client _httpClient;

  HttpClientImpl() {
    _httpClient = Client();
  }

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
