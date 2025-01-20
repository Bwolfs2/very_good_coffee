import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

sealed class NewCoffeeImageEvent {}

class LoadNewCoffeeImageEvent extends NewCoffeeImageEvent {}

class FavoriteNewCoffeeImageEvent extends NewCoffeeImageEvent {
  final CoffeeImage image;

  FavoriteNewCoffeeImageEvent(this.image);
}
