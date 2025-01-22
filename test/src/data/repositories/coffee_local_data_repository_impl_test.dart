import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_data_abstractions/local_data_abstractions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee/src/data/repositories/coffee_local_data_repository_impl.dart';
import 'package:very_good_coffee/src/domain/failures/failures.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

class MockCoffeeLocalDataSource extends Mock implements CoffeeLocalDataSource {}

void main() {
  late CoffeeLocalDataSource mockDataSource;
  late CoffeeLocalDataRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCoffeeLocalDataSource();
    repository = CoffeeLocalDataRepositoryImpl(mockDataSource);
  });

  setUpAll(() {
    registerFallbackValue(
        CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3])));
    registerFallbackValue(
        CoffeeImageDto(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3])));
  });

  group('getAllFavoritedCoffee', () {
    test('should return a list of CoffeeImage on success', () async {
      final mockCoffeeDtos = [
        CoffeeImageDto(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3])),
        CoffeeImageDto(id: '2', fileEncoded: Uint8List.fromList([4, 5, 6])),
      ];

      when(() => mockDataSource.getAllFavoritedCoffee())
          .thenAnswer((_) async => mockCoffeeDtos);

      final result = await repository.getAllFavoritedCoffee();

      expect(result, isA<Success<Failure, List<CoffeeImage>>>());
      expect(result.getSuccess().length, 2);
      verify(() => mockDataSource.getAllFavoritedCoffee()).called(1);
    });

    test('should return error on exception', () async {
      when(() => mockDataSource.getAllFavoritedCoffee()).thenThrow(Exception());

      final result = await repository.getAllFavoritedCoffee();

      expect(result, isA<Error<Failure, List<CoffeeImage>>>());
      expect(result.getError(), isA<NoFavoriteCoffeeException>());
      verify(() => mockDataSource.getAllFavoritedCoffee()).called(1);
    });
  });

  group('deleteFavoriteCoffee', () {
    test('should succeed when data source call succeeds', () async {
      final coffee =
          CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.deleteFavoriteCoffee(any()))
          .thenAnswer((_) async {});

      final result = await repository.deleteFavoriteCoffee(coffee);

      expect(result, isA<Success<Failure, void>>());
      verify(() => mockDataSource.deleteFavoriteCoffee(
              CoffeeImageDto(id: coffee.id, fileEncoded: coffee.fileEncoded)))
          .called(1);
    });

    test('should return error on exception', () async {
      final coffee =
          CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.deleteFavoriteCoffee(any()))
          .thenThrow(Exception());

      final result = await repository.deleteFavoriteCoffee(coffee);

      expect(result, isA<Error<Failure, void>>());
      expect(result.getError(), isA<FailedToDeleteFavoriteCoffeeException>());
      verify(() => mockDataSource.deleteFavoriteCoffee(
              CoffeeImageDto(id: coffee.id, fileEncoded: coffee.fileEncoded)))
          .called(1);
    });
  });

  group('saveFavoriteCoffee', () {
    test('should succeed when data source call succeeds', () async {
      final coffee =
          CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.insertFavoriteCoffee(any()))
          .thenAnswer((_) async {});

      final result = await repository.saveFavoriteCoffee(coffee);

      expect(result, isA<Success<Failure, void>>());
      verify(() => mockDataSource.insertFavoriteCoffee(
              CoffeeImageDto(id: coffee.id, fileEncoded: coffee.fileEncoded)))
          .called(1);
    });

    test('should return error on exception', () async {
      final coffee =
          CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.insertFavoriteCoffee(any()))
          .thenThrow(Exception());

      final result = await repository.saveFavoriteCoffee(coffee);

      expect(result, isA<Error<Failure, void>>());
      expect(result.getError(), isA<FailedToSaveFavoriteCoffeeException>());
      verify(() => mockDataSource.insertFavoriteCoffee(
              CoffeeImageDto(id: coffee.id, fileEncoded: coffee.fileEncoded)))
          .called(1);
    });
  });

  group('getFavoriteCoffeeCount', () {
    test('should return coffee count on success', () async {
      when(() => mockDataSource.getFavoriteCoffeeCount())
          .thenAnswer((_) async => 5);

      final result = await repository.getFavoriteCoffeeCount();

      expect(result, isA<Success<Failure, int>>());
      expect(result.getSuccess(), 5);
      verify(() => mockDataSource.getFavoriteCoffeeCount()).called(1);
    });

    test('should return error on exception', () async {
      when(() => mockDataSource.getFavoriteCoffeeCount())
          .thenThrow(Exception());

      final result = await repository.getFavoriteCoffeeCount();

      expect(result, isA<Error<Failure, int>>());
      expect(result.getError(), isA<NoFavoriteCoffeeCountException>());
      verify(() => mockDataSource.getFavoriteCoffeeCount()).called(1);
    });
  });

  group('getBackgroundCoffee', () {
    test('should return CoffeeImage on success', () async {
      final mockCoffeeDto =
          CoffeeImageDto(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.getBackgroundCoffee())
          .thenAnswer((_) async => mockCoffeeDto);

      final result = await repository.getBackgroundCoffee();

      expect(result, isA<Success<Failure, CoffeeImage>>());
      expect(result.getSuccess().id, '1');
      verify(() => mockDataSource.getBackgroundCoffee()).called(1);
    });

    test('should return error on exception', () async {
      when(() => mockDataSource.getBackgroundCoffee()).thenThrow(Exception());

      final result = await repository.getBackgroundCoffee();

      expect(result, isA<Error<Failure, CoffeeImage>>());
      expect(result.getError(), isA<NoBackgroundCoffeeException>());
      verify(() => mockDataSource.getBackgroundCoffee()).called(1);
    });
  });

  group('setBackgroundCoffee', () {
    test('should succeed when data source call succeeds', () async {
      final coffee =
          CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.setBackgroundCoffee(any()))
          .thenAnswer((_) async {});

      final result = await repository.setBackgroundCoffee(coffee);

      expect(result, isA<Success<Failure, void>>());
      verify(() => mockDataSource.setBackgroundCoffee(
              CoffeeImageDto(id: coffee.id, fileEncoded: coffee.fileEncoded)))
          .called(1);
    });

    test('should return error on exception', () async {
      final coffee =
          CoffeeImage(id: '1', fileEncoded: Uint8List.fromList([1, 2, 3]));

      when(() => mockDataSource.setBackgroundCoffee(any()))
          .thenThrow(Exception());

      final result = await repository.setBackgroundCoffee(coffee);

      expect(result, isA<Error<Failure, void>>());
      expect(result.getError(), isA<NoBackgroundCoffeeException>());
      verify(() => mockDataSource.setBackgroundCoffee(
              CoffeeImageDto(id: coffee.id, fileEncoded: coffee.fileEncoded)))
          .called(1);
    });
  });
}
