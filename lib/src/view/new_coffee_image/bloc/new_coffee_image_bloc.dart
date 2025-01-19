import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/repoistories/coffee_api_repository.dart';

import 'new_coffee_image_events.dart';
import 'new_coffee_image_states.dart';

class NewCoffeeImageBloc
    extends Bloc<NewCoffeeImageEvent, NewCoffeeImageState> {
  final CoffeeApiRepository _coffeeImageRepository;

  NewCoffeeImageBloc(this._coffeeImageRepository)
      : super(NewCoffeeImageInitial()) {
    on<LoadNewCoffeeImageEvent>((event, emit) async {
      emit(NewCoffeeImageLoading());
      final image = await _coffeeImageRepository.getCoffee();
      emit(NewCoffeeImageLoaded(image));
    });
  }
}
