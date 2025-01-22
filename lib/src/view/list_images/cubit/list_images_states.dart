import '../../../domain/model/coffee_image.dart';

sealed class ListImagesStates {}

class ListImagesInitial extends ListImagesStates {}

class ListImagesLoaded extends ListImagesStates {
  final List<CoffeeImage> coffeeImages;

  ListImagesLoaded(this.coffeeImages);
}

class ListImagesError extends ListImagesStates {
  final String message;

  ListImagesError(this.message);
}
