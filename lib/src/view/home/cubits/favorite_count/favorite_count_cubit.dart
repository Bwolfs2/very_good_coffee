import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/view/home/cubits/favorite_count/favorite_count_states.dart';

import '../../../../domain/repositories/coffee_local_data_repository.dart';

class FavoriteCountCubit extends Cubit<FavoriteCountStates> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;
  FavoriteCountCubit(this._coffeeLocalDataRepository)
      : super(FavoriteCountInitial());

  Future<void> getFavoriteCount() async {
    final count = await _coffeeLocalDataRepository.getFavoriteCoffeeCount();

    count.fold(
      (failure) => emit(FavoriteCountError(failure.message)),
      (count) => emit(FavoriteCountLoaded(count)),
    );
  }
}
