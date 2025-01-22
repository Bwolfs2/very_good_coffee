import 'package:core/core.dart';
import 'package:local_data_abstractions/local_data_abstractions.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

import '../../domain/failures/failures.dart';
import '../../domain/repositories/coffee_local_data_repository.dart';

class CoffeeLocalDataRepositoryImpl extends CoffeeLocalDataRepository {
  final CoffeeLocalDataSource _coffeeDataSource;

  CoffeeLocalDataRepositoryImpl(this._coffeeDataSource);

  @override
  Future<Result<Failure, List<CoffeeImage>>> getAllFavoritedCoffee() async {
    try {
      final coffeeImages = await _coffeeDataSource.getAllFavoritedCoffee();
      return Result.success(
        coffeeImages
            .map((e) => CoffeeImage(id: e.id, fileEncoded: e.fileEncoded))
            .toList(),
      );
    } catch (e) {
      return Result.error(NoFavoriteCoffeeException());
    }
  }

  @override
  Future<Result<Failure, void>> deleteFavoriteCoffee(CoffeeImage coffee) async {
    try {
      await _coffeeDataSource.deleteFavoriteCoffee(
        CoffeeImageDto(
          id: coffee.id,
          fileEncoded: coffee.fileEncoded,
        ),
      );
      return Result.success(null);
    } catch (e) {
      return Result.error(FailedToDeleteFavoriteCoffeeException());
    }
  }

  @override
  Future<Result<Failure, void>> saveFavoriteCoffee(CoffeeImage coffee) async {
    try {
      await _coffeeDataSource.insertFavoriteCoffee(
        CoffeeImageDto(
          id: coffee.id,
          fileEncoded: coffee.fileEncoded,
        ),
      );
      return Result.success(null);
    } catch (e) {
      return Result.error(FailedToSaveFavoriteCoffeeException());
    }
  }

  @override
  Future<Result<Failure, int>> getFavoriteCoffeeCount() async {
    try {
      return Result.success(await _coffeeDataSource.getFavoriteCoffeeCount());
    } catch (e) {
      return Result.error(NoFavoriteCoffeeCountException());
    }
  }

  @override
  Future<Result<Failure, CoffeeImage>> getBackgroundCoffee() async {
    try {
      final coffeeImage = await _coffeeDataSource.getBackgroundCoffee();
      return Result.success(
        CoffeeImage(
          id: coffeeImage.id,
          fileEncoded: coffeeImage.fileEncoded,
        ),
      );
    } catch (e) {
      return Result.error(NoBackgroundCoffeeException());
    }
  }

  @override
  Future<Result<Failure, void>> setBackgroundCoffee(CoffeeImage coffee) async {
    try {
      await _coffeeDataSource.setBackgroundCoffee(
        CoffeeImageDto(
          id: coffee.id,
          fileEncoded: coffee.fileEncoded,
        ),
      );
      return Result.success(null);
    } catch (e) {
      return Result.error(NoBackgroundCoffeeException());
    }
  }
}
