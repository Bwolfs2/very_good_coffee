import 'package:core/core.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

import '../failures/failures.dart';

abstract class CoffeeLocalDataRepository {
  Future<Result<Failure, CoffeeImage>> getBackgroundCoffee();
  Future<Result<Failure, void>> setBackgroundCoffee(CoffeeImage coffee);
  Future<Result<Failure, void>> saveFavoriteCoffee(CoffeeImage coffee);
  Future<Result<Failure, List<CoffeeImage>>> getAllFavoritedCoffee();
  Future<Result<Failure, void>> deleteFavoriteCoffee(CoffeeImage coffee);
  Future<Result<Failure, int>> getFavoriteCoffeeCount();
}
