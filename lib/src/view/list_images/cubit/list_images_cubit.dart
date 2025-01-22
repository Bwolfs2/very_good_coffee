import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repoistories/coffee_local_data_repository.dart';
import 'list_images_states.dart';

class ListImagesCubit extends Cubit<ListImagesStates> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  ListImagesCubit(
    this._coffeeLocalDataRepository,
  ) : super(ListImagesInitial());

  Future<void> loadFavoritedCoffee() async {
    final coffeeImages =
        await _coffeeLocalDataRepository.getAllFavoritedCoffee();

    coffeeImages.fold(
      (failure) => emit(ListImagesError(failure.message)),
      (coffeeImages) => emit(ListImagesLoaded(coffeeImages)),
    );
  }
}
