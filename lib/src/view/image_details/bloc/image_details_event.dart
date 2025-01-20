import '../../../domain/model/coffee_image.dart';

abstract class ImageDetailsEvent {}

class ImageDetailsLoadEvent extends ImageDetailsEvent {
  final CoffeeImage image;

  ImageDetailsLoadEvent(this.image);
}

class ImageDetailsSetAsBackgroundEvent extends ImageDetailsEvent {
  final CoffeeImage image;

  ImageDetailsSetAsBackgroundEvent(this.image);
}

class ImageDetailsRemoveFromFavoritesEvent extends ImageDetailsEvent {
  final CoffeeImage image;

  ImageDetailsRemoveFromFavoritesEvent(this.image);
}
