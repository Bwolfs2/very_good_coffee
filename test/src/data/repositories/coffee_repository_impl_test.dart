import 'dart:convert';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/src/data/repositories/coffee_repository_impl.dart';
import 'package:very_good_coffee/src/domain/failures/failures.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

class MockHttpClient extends Mock implements IHttpClient {}

void main() {
  late CoffeeApiRepositoryImpl coffeeApiRepository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    coffeeApiRepository = CoffeeApiRepositoryImpl(httpClient: mockHttpClient);
  });

  group('CoffeeApiRepositoryImpl', () {
    test('should return a CoffeeImage on successful API call', () async {
      // Arrange
      final mockResponse = {'file': 'http://example.com/coffee.png'};
      final mockBytecode = Uint8List.fromList([0, 1, 2, 3]);
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => HttpClientResponse(
          data: jsonEncode(mockResponse),
          statusCode: 200,
        ),
      );
      when(() => mockHttpClient.getBytecode(any())).thenAnswer(
        (_) async => HttpClientResponse(
          data: mockBytecode,
          statusCode: 200,
        ),
      );

      // Act
      final result = await coffeeApiRepository.getCoffee();

      // Assert
      expect(result, isA<Success<Failure, CoffeeImage>>());
      expect(result.getSuccess().fileEncoded, mockBytecode);
      verify(() => mockHttpClient.get(any())).called(1);
      verify(() => mockHttpClient.getBytecode(any())).called(1);
    });

    test('should return FailedToGetCoffeeException on failure', () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenThrow(FailedToGetCoffeeException());

      // Act
      final result = await coffeeApiRepository.getCoffee();

      // Assert
      expect(result, isA<Error<Failure, CoffeeImage>>());

      expect(result.getError(), isA<FailedToGetCoffeeException>());
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should return FailedToGetByteCodeCoffeeException on bytecode failure',
        () async {
      // Arrange
      final mockResponse = {'file': 'http://example.com/coffee.png'};
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => HttpClientResponse(
          data: jsonEncode(mockResponse),
          statusCode: 200,
        ),
      );
      when(() => mockHttpClient.getBytecode(any())).thenThrow(
        FailedToGetByteCodeCoffeeException(),
      );

      // Act
      final result = await coffeeApiRepository.getCoffee();

      // Assert
      expect(result, isA<Error<Failure, CoffeeImage>>());
      expect(result.getError(), isA<FailedToGetByteCodeCoffeeException>());
      verify(() => mockHttpClient.get(any())).called(1);
      verify(() => mockHttpClient.getBytecode(any())).called(1);
    });
  });
}
