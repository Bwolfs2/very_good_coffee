import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

abstract class CoffeeLocalDataRepository {
  Future<CoffeeImage> getBackgroundCoffee();
  Future<void> setBackgroundCoffee(CoffeeImage coffee);
  Future<void> saveCoffee(CoffeeImage coffee);
  Future<List<CoffeeImage>> getAllFavoritedCoffee();
  Future<void> deleteCoffee(CoffeeImage coffee);
}
