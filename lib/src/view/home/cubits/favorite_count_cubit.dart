import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repoistories/coffee_local_data_repository.dart';

class FavoriteCountCubit extends Cubit<int?> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;
  FavoriteCountCubit(this._coffeeLocalDataRepository) : super(null);

  Future<void> getFavoriteCount() async {
    final count = await _coffeeLocalDataRepository.getFavoriteCoffeeCount();
    emit(count);
  }
}
