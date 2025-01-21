import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/coffee_image.dart';
import '../../../domain/repoistories/coffee_local_data_repository.dart';

class BackgroundCubit extends Cubit<BackgroundStates> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  BackgroundCubit(this._coffeeLocalDataRepository) : super(BackgroundInitial());

  Future<void> loadBackground() async {
    try {
      final image = await _coffeeLocalDataRepository.getBackgroundCoffee();
      emit(BackgroundLoaded(image));
    } catch (e) {
      emit(BackgroundError(e.toString()));
    }
  }
}

sealed class BackgroundStates {}

class BackgroundInitial extends BackgroundStates {}

class BackgroundLoaded extends BackgroundStates {
  final CoffeeImage image;

  BackgroundLoaded(this.image);
}

class BackgroundError extends BackgroundStates {
  final String message;

  BackgroundError(this.message);
}
