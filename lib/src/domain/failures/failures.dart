class Failure implements Exception {
  final String message;

  Failure(this.message);
}

class NoFavoriteCoffeeException extends Failure {
  NoFavoriteCoffeeException() : super('No favorite coffee images found');
}

class NoBackgroundCoffeeException extends Failure {
  NoBackgroundCoffeeException() : super('No background coffee images found');
}

class NoCoffeeImagesException extends Failure {
  NoCoffeeImagesException() : super('No coffee images found');
}

class NoFavoriteCoffeeCountException extends Failure {
  NoFavoriteCoffeeCountException() : super('No favorite coffee count found');
}

class FailedToSaveFavoriteCoffeeException extends Failure {
  FailedToSaveFavoriteCoffeeException()
      : super('Failed to save favorite coffee');
}

class FailedToDeleteFavoriteCoffeeException extends Failure {
  FailedToDeleteFavoriteCoffeeException()
      : super('Failed to delete favorite coffee');
}

class FailedToGetCoffeeException extends Failure {
  FailedToGetCoffeeException() : super('Failed to get coffee');
}

class FailedToGetByteCodeCoffeeException extends Failure {
  FailedToGetByteCodeCoffeeException() : super('Failed to get bytecode coffee');
}
