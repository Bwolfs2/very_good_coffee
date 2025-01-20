import 'package:local_data_abstractions/local_data_abstractions.dart';

import '../drift/coffee_database.dart';

class CoffeeDataSourceDriftImpl extends CoffeeLocalDataSource {
  late final CoffeeDatabase _database;

  CoffeeDataSourceDriftImpl() {
    _database = CoffeeDatabase();
  }

  @override
  Future<void> deleteFavoriteCoffee(CoffeeImageDto coffee) async {
    await _database.deleteCoffeeImage(
        CoffeeImage(id: coffee.id, fileEncoded: coffee.fileEncoded));
  }

  @override
  Future<int> getFavoriteCoffeeCount() async {
    return (await _database.allCoffeeImages).length;
  }

  @override
  Future<List<CoffeeImageDto>> getAllFavoritedCoffee() async {
    final coffeeImages = await _database.allCoffeeImages;
    return coffeeImages
        .map((e) => CoffeeImageDto(id: e.id, fileEncoded: e.fileEncoded))
        .toList();
  }

  @override
  Future<void> insertFavoriteCoffee(CoffeeImageDto coffee) async {
    await _database.insertCoffeeImage(
        CoffeeImage(id: coffee.id, fileEncoded: coffee.fileEncoded));
  }

  @override
  Future<CoffeeImageDto> getBackgroundCoffee() async {
    final backgroundCoffeeImages = await _database.allBackgroundCoffeeImages;

    if (backgroundCoffeeImages.isEmpty) {
      throw Exception('No background coffee images found');
    }

    return CoffeeImageDto(
      id: backgroundCoffeeImages.last.id,
      fileEncoded: backgroundCoffeeImages.last.fileEncoded,
    );
  }

  @override
  Future<void> setBackgroundCoffee(CoffeeImageDto coffee) async {
    await _database.insertBackgroundCoffeeImage(
        BackgroundCoffeeImage(id: coffee.id, fileEncoded: coffee.fileEncoded));
  }
}
