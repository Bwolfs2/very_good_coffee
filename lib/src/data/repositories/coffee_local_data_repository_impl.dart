import 'package:local_data_abstractions/local_data_abstractions.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

import '../../domain/failures/failures.dart';
import '../../domain/repoistories/coffee_local_data_repository.dart';

class CoffeeLocalDataRepositoryImpl extends CoffeeLocalDataRepository {
  final CoffeeLocalDataSource _coffeeDataSource;

  CoffeeLocalDataRepositoryImpl(this._coffeeDataSource);

  @override
  Future<List<CoffeeImage>> getAllFavoritedCoffee() async {
    try {
      final coffeeImages = await _coffeeDataSource.getAllFavoritedCoffee();
      return coffeeImages
          .map((e) => CoffeeImage(id: e.id, fileEncoded: e.fileEncoded))
          .toList();
    } catch (e) {
      throw NoFavoriteCoffeeException();
    }
  }

  @override
  Future<void> deleteFavoriteCoffee(CoffeeImage coffee) async {
    try {
      await _coffeeDataSource.deleteFavoriteCoffee(
        CoffeeImageDto(
          id: coffee.id,
          fileEncoded: coffee.fileEncoded,
        ),
      );
    } catch (e) {
      throw FailedToDeleteFavoriteCoffeeException();
    }
  }

  @override
  Future<void> saveFavoriteCoffee(CoffeeImage coffee) async {
    try {
      await _coffeeDataSource.insertFavoriteCoffee(
        CoffeeImageDto(
          id: coffee.id,
          fileEncoded: coffee.fileEncoded,
        ),
      );
    } catch (e) {
      throw FailedToSaveFavoriteCoffeeException();
    }
  }

  @override
  Future<int> getFavoriteCoffeeCount() async {
    try {
      return await _coffeeDataSource.getFavoriteCoffeeCount();
    } catch (e) {
      throw NoFavoriteCoffeeCountException();
    }
  }

  @override
  Future<CoffeeImage> getBackgroundCoffee() async {
    try {
      final coffeeImage = await _coffeeDataSource.getBackgroundCoffee();
      return CoffeeImage(
          id: coffeeImage.id, fileEncoded: coffeeImage.fileEncoded);
    } catch (e) {
      throw NoBackgroundCoffeeException();
    }
  }

  @override
  Future<void> setBackgroundCoffee(CoffeeImage coffee) async {
    try {
      await _coffeeDataSource.setBackgroundCoffee(
        CoffeeImageDto(
          id: coffee.id,
          fileEncoded: coffee.fileEncoded,
        ),
      );
    } catch (e) {
      throw NoBackgroundCoffeeException();
    }
  }
}
