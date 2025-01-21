import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

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

    return CoffeeImage(
      id: const Uuid().v4(),
      fileEncoded: bytecode,
    );
  }

  Future<Uint8List> getBytecodeFromUrl(String url) async {
    try {
      final response = await _httpClient.getBytecode(url);
      log(response.toString());
      return response.data;
    } catch (e) {
      throw Exception('Failed to get bytecode from url: $e');
    }
  }
}
