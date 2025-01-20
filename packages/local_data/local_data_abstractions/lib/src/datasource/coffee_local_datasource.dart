import '../dto/coffee_image_dto.dart';

abstract class CoffeeLocalDataSource {
  Future<void> insertFavoriteCoffee(CoffeeImageDto coffee);
  Future<void> deleteFavoriteCoffee(CoffeeImageDto coffee);
  Future<List<CoffeeImageDto>> getAllFavoritedCoffee();
  Future<CoffeeImageDto> getBackgroundCoffee();
  Future<void> setBackgroundCoffee(CoffeeImageDto coffee);
  Future<int> getFavoriteCoffeeCount();
}
