import 'package:blend/blend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/repoistories/coffee_api_repository.dart';
import 'package:very_good_coffee/src/view/new_coffee_image/bloc/new_coffee_image_bloc.dart';
import 'package:very_good_coffee/src/view/new_coffee_image/bloc/new_coffee_image_events.dart';

import 'bloc/new_coffee_image_states.dart';

class NewCoffeeImagePage extends StatelessWidget {
  const NewCoffeeImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCoffeeImageBloc(
        context.read<CoffeeApiRepository>(),
      )..add(LoadNewCoffeeImageEvent()),
      child: const _NewCoffeeImageBody(),
    );
  }
}

class _NewCoffeeImageBody extends StatefulWidget {
  const _NewCoffeeImageBody();

  @override
  State<_NewCoffeeImageBody> createState() => _NewCoffeeImageBodyState();
}

class _NewCoffeeImageBodyState extends State<_NewCoffeeImageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Coffee Image'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh),
      ),
      body: BlocBuilder<NewCoffeeImageBloc, NewCoffeeImageState>(
        builder: (context, state) {
          return switch (state) {
            NewCoffeeImageInitial() || NewCoffeeImageLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            NewCoffeeImageLoaded(image: final image) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: BlendCardImage(
                      bytecode: image.bytecode,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Favorite'),
                  ),
                ],
              )
          };
        },
      ),
    );
  }
}
