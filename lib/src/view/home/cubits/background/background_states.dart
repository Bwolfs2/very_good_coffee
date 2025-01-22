import '../../../../domain/model/coffee_image.dart';

sealed class BackgroundStates {}

class BackgroundInitial extends BackgroundStates {}

class BackgroundLoaded extends BackgroundStates {
  final CoffeeImage image;

  BackgroundLoaded(this.image);
}

class BackgroundError extends BackgroundStates {
  final String message;

  BackgroundError(this.message);
}
