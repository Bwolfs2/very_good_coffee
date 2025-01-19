import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

abstract class CoffeeApiRepository {
  Future<CoffeeImage> getCoffee();
}
