import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/failures/failures.dart';
import '../../domain/model/coffee_image.dart';
import '../../domain/repositories/coffee_api_repository.dart';

class CoffeeApiRepositoryImpl implements CoffeeApiRepository {
  final IHttpClient _httpClient;

  CoffeeApiRepositoryImpl({required IHttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<Result<Failure, CoffeeImage>> getCoffee() async {
    try {
      final response = await _httpClient.get(Environment.kApiUrl);

      final json = jsonDecode(response.data);

      final bytecode = await getBytecodeFromUrl(json['file']);

      return Result.success(
        CoffeeImage(
          id: const Uuid().v4(),
          fileEncoded: bytecode,
        ),
      );
    } on Failure catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(FailedToGetCoffeeException());
    }
  }

  Future<Uint8List> getBytecodeFromUrl(String url) async {
    try {
      final response = await _httpClient.getBytecode(url);

      return response.data;
    } catch (e) {
      throw FailedToGetByteCodeCoffeeException();
    }
  }
}
