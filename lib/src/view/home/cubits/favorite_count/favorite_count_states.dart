sealed class FavoriteCountStates {}

class FavoriteCountInitial extends FavoriteCountStates {}

class FavoriteCountLoaded extends FavoriteCountStates {
  final int count;

  FavoriteCountLoaded(this.count);
}

class FavoriteCountError extends FavoriteCountStates {
  final String message;

  FavoriteCountError(this.message);
}
