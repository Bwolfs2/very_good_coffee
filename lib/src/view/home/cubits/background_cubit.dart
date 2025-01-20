import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/coffee_image.dart';
import '../../../domain/repoistories/coffee_local_data_repository.dart';

class BackgroundCubit extends Cubit<CoffeeImage?> {
  final CoffeeLocalDataRepository _coffeeLocalDataRepository;

  BackgroundCubit(this._coffeeLocalDataRepository) : super(null);

  Future<void> loadBackground() async {
    try {
      final image = await _coffeeLocalDataRepository.getBackgroundCoffee();
      emit(image);
    } catch (e) {
      emit(null);
    }
  }
}
