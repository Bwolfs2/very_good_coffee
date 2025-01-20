import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repoistories/coffee_local_data_repository.dart';
import 'image_details_event.dart';
import 'image_details_state.dart';

class ImageDetailsBloc extends Bloc<ImageDetailsEvent, ImageDetailsState> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  ImageDetailsBloc(this._coffeeLocalDataRepository)
      : super(ImageDetailsInitial()) {
    on<ImageDetailsLoadEvent>((event, emit) {
      emit(ImageDetailsLoading());
      emit(ImageDetailsLoaded(
        event.image,
      ));
    });

    on<ImageDetailsSetAsBackgroundEvent>((event, emit) async {
      emit(ImageDetailsLoading());
      await _coffeeLocalDataRepository.setBackgroundCoffee(event.image);
      emit(ImageDetailsSetAsBackground(
        event.image,
      ));
    });

    on<ImageDetailsRemoveFromFavoritesEvent>((event, emit) async {
      emit(ImageDetailsLoading());
      await _coffeeLocalDataRepository.deleteFavoriteCoffee(event.image);
      emit(ImageDetailsRemoveFromFavorites(
        event.image,
      ));
    });
  }
}
