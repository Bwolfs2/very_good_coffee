import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/coffee_image.dart';
import '../../../domain/repoistories/coffee_local_data_repository.dart';

class ListImagesCubit extends Cubit<List<CoffeeImage>?> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  ListImagesCubit(
    this._coffeeLocalDataRepository,
  ) : super(null);

  Future<void> loadFavoritedCoffee() async {
    final coffeeImages =
        await _coffeeLocalDataRepository.getAllFavoritedCoffee();
    emit(coffeeImages);
  }
}
