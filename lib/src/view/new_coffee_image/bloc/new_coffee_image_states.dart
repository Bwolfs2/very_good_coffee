import '../../../domain/model/coffee_image.dart';

sealed class NewCoffeeImageState {}

class NewCoffeeImageInitial extends NewCoffeeImageState {}

class NewCoffeeImageLoading extends NewCoffeeImageState {}

class NewCoffeeImageLoaded extends NewCoffeeImageState {
  final CoffeeImage image;

  NewCoffeeImageLoaded(this.image);
}

class NewCoffeeImageFavorited extends NewCoffeeImageState {
  final CoffeeImage image;

  NewCoffeeImageFavorited(this.image);
}
