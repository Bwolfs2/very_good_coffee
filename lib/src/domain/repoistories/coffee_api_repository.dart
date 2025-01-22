import 'package:core/core.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

import '../failures/failures.dart';

abstract class CoffeeApiRepository {
  Future<Result<Failure, CoffeeImage>> getCoffee();
}
