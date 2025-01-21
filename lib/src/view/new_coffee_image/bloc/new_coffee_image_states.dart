import '../../../domain/model/coffee_image.dart';

sealed class NewCoffeeImageState {
  const NewCoffeeImageState();
}

class NewCoffeeImageInitial extends NewCoffeeImageState {
  const NewCoffeeImageInitial();
}

class NewCoffeeImageLoading extends NewCoffeeImageState {
  const NewCoffeeImageLoading();
}

class NewCoffeeImageLoaded extends NewCoffeeImageState {
  final CoffeeImage image;

  const NewCoffeeImageLoaded(this.image);
}

class NewCoffeeImageFavorited extends NewCoffeeImageState {
  const NewCoffeeImageFavorited();
}
