import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/repositories/coffee_api_repository.dart';
import 'package:very_good_coffee/src/domain/repositories/coffee_local_data_repository.dart';

import '../../../domain/model/coffee_image.dart';
import 'new_coffee_image_states.dart';

class NewCoffeeImageBloc extends Cubit<NewCoffeeImageState> {
  final CoffeeApiRepository _coffeeImageRepository;
  final CoffeeLocalDataRepository _coffeeLocalRepository;

  NewCoffeeImageBloc(this._coffeeImageRepository, this._coffeeLocalRepository)
      : super(NewCoffeeImageInitial());

  void loadNewCoffeeImage() async {
    emit(NewCoffeeImageLoading());
    final image = await _coffeeImageRepository.getCoffee();
    image.fold(
      (failure) => emit(NewCoffeeImageError(failure.message)),
      (image) => emit(NewCoffeeImageLoaded(image)),
    );
  }

  void favoriteNewCoffeeImage(CoffeeImage image) async {
    await _coffeeLocalRepository.saveFavoriteCoffee(image);

    emit(NewCoffeeImageFavorited());
  }
}
