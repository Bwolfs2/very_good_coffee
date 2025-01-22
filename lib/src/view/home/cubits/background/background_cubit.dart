import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/coffee_local_data_repository.dart';
import 'background_states.dart';

class BackgroundCubit extends Cubit<BackgroundStates> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  BackgroundCubit(this._coffeeLocalDataRepository) : super(BackgroundInitial());

  Future<void> loadBackground() async {
    final image = await _coffeeLocalDataRepository.getBackgroundCoffee();

    image.fold(
      (failure) => emit(BackgroundError(failure.message)),
      (image) => emit(BackgroundLoaded(image)),
    );
  }
}
