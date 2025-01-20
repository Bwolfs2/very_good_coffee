import 'package:local_data_abstractions/local_data_abstractions.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

import '../../domain/repoistories/coffee_local_data_repository.dart';

class CoffeeLocalDataRepositoryImpl extends CoffeeLocalDataRepository {
  final CoffeeLocalDataSource _coffeeDataSource;

  CoffeeLocalDataRepositoryImpl(this._coffeeDataSource);

  @override
  Future<List<CoffeeImage>> getAllFavoritedCoffee() async {
    final coffeeImages = await _coffeeDataSource.getAllFavoritedCoffee();
    return coffeeImages
        .map((e) => CoffeeImage(id: e.id, fileEncoded: e.fileEncoded))
        .toList();
  }

  @override
  Future<void> deleteFavoriteCoffee(CoffeeImage coffee) async {
    await _coffeeDataSource.deleteFavoriteCoffee(
      CoffeeImageDto(
        id: coffee.id,
        fileEncoded: coffee.fileEncoded,
      ),
    );
  }

  @override
  Future<void> saveFavoriteCoffee(CoffeeImage coffee) async {
    await _coffeeDataSource.insertFavoriteCoffee(
      CoffeeImageDto(
        id: coffee.id,
        fileEncoded: coffee.fileEncoded,
      ),
    );
  }

  @override
  Future<int> getFavoriteCoffeeCount() async {
    return await _coffeeDataSource.getFavoriteCoffeeCount();
  }

  @override
  Future<CoffeeImage> getBackgroundCoffee() async {
    try {
      final coffeeImage = await _coffeeDataSource.getBackgroundCoffee();
      return CoffeeImage(
          id: coffeeImage.id, fileEncoded: coffeeImage.fileEncoded);
    } catch (e) {
      throw Exception('No background coffee images found');
    }
  }

  @override
  Future<void> setBackgroundCoffee(CoffeeImage coffee) async {
    await _coffeeDataSource.setBackgroundCoffee(
      CoffeeImageDto(
        id: coffee.id,
        fileEncoded: coffee.fileEncoded,
      ),
    );
  }
}
