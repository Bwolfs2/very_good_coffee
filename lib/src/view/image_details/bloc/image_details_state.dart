import '../../../domain/model/coffee_image.dart';

sealed class ImageDetailsState {}

class ImageDetailsInitial extends ImageDetailsState {}

class ImageDetailsLoading extends ImageDetailsState {}

class ImageDetailsLoaded extends ImageDetailsState {
  final CoffeeImage image;

  ImageDetailsLoaded(this.image);
}

class ImageDetailsSetAsBackground extends ImageDetailsState {
  final CoffeeImage image;

  ImageDetailsSetAsBackground(this.image);
}

class ImageDetailsRemoveFromFavorites extends ImageDetailsState {
  final CoffeeImage image;

  ImageDetailsRemoveFromFavorites(this.image);
}
