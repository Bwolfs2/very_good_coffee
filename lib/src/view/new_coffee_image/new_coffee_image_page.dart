import 'package:blend/blend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/repoistories/coffee_api_repository.dart';
import 'package:very_good_coffee/src/domain/repoistories/coffee_local_data_repository.dart';
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
        context.read<CoffeeLocalDataRepository>(),
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
        onPressed: () {
          context.read<NewCoffeeImageBloc>().add(LoadNewCoffeeImageEvent());
        },
        child: const Icon(Icons.refresh),
      ),
      body: BlocConsumer<NewCoffeeImageBloc, NewCoffeeImageState>(
        listener: (context, state) {
          if (state is NewCoffeeImageFavorited) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coffee image favorited saved!'),
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            NewCoffeeImageInitial() || NewCoffeeImageLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            NewCoffeeImageLoaded(image: final image) ||
            NewCoffeeImageFavorited(image: final image) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Animate(
                      effects: [
                        FlipEffect(
                          delay: 300.milliseconds,
                          direction: Axis.horizontal,
                        ),
                      ],
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: BlendCardImage(
                          bytecode: image.fileEncoded,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: FilledButton(
                            onPressed: () {
                              context.read<NewCoffeeImageBloc>().add(
                                    FavoriteNewCoffeeImageEvent(image),
                                  );
                            },
                            child: const Text('Favorite'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              )
          };
        },
      ),
    );
  }
}
