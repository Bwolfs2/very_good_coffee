import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/http_client.dart';
import '../../domain/model/coffee_image.dart';
import '../../domain/repoistories/coffee_api_repository.dart';

class CoffeeApiRepositoryImpl implements CoffeeApiRepository {
  final IHttpClient _httpClient;

  CoffeeApiRepositoryImpl({required IHttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<CoffeeImage> getCoffee() async {
    final response =
        await _httpClient.get('https://coffee.alexflipnote.dev/random.json');

    final json = jsonDecode(response.data);

    final bytecode = await getBytecodeFromUrl(json['file']);

    return CoffeeImage(bytecode: bytecode, generatedAt: DateTime.now());
  }

  Future<Uint8List> getBytecodeFromUrl(String url) async {
    final response = await _httpClient.get(url);
    return base64Decode(response.data);
  }
}
