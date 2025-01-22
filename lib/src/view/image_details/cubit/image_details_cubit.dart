import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/coffee_image.dart';
import '../../../domain/repositories/coffee_local_data_repository.dart';
import 'image_details_state.dart';

class ImageDetailsBloc extends Cubit<ImageDetailsState> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  ImageDetailsBloc(this._coffeeLocalDataRepository)
      : super(ImageDetailsInitial());

  void loadImageDetails(CoffeeImage image) {
    emit(ImageDetailsLoading());
    emit(ImageDetailsLoaded(image));
  }

  void setAsBackground(CoffeeImage image) async {
    await _coffeeLocalDataRepository.setBackgroundCoffee(image);
    emit(ImageDetailsSetAsBackground(image));
  }

  void removeFromFavorites(CoffeeImage image) async {
    await _coffeeLocalDataRepository.deleteFavoriteCoffee(image);
    emit(ImageDetailsRemoveFromFavorites(image));
  }
}
