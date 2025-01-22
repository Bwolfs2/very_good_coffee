import 'package:blend/blend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/repositories/coffee_api_repository.dart';
import 'package:very_good_coffee/src/domain/repositories/coffee_local_data_repository.dart';
import 'package:very_good_coffee/src/view/new_coffee_image/cubit/new_coffee_image_cubit.dart';

import 'cubit/new_coffee_image_states.dart';

class NewCoffeeImagePage extends StatelessWidget {
  const NewCoffeeImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCoffeeImageBloc(
        context.read<CoffeeApiRepository>(),
        context.read<CoffeeLocalDataRepository>(),
      )..loadNewCoffeeImage(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<NewCoffeeImageBloc, NewCoffeeImageState>(
        builder: (context, state) {
          if (state is NewCoffeeImageInitial ||
              state is NewCoffeeImageLoading) {
            return const SizedBox.shrink();
          }

          if (state is NewCoffeeImageLoaded) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Animate(
                  effects: [
                    ScaleEffect(
                      delay: 350.milliseconds,
                      begin: Offset(0.0, 0.0),
                      end: Offset(1.0, 1.0),
                    ),
                  ],
                  child: FloatingActionButton(
                    tooltip: 'Get new coffee image',
                    onPressed: () {
                      context.read<NewCoffeeImageBloc>().loadNewCoffeeImage();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ),
                const SizedBox(width: 32),
                Animate(
                  effects: [
                    ScaleEffect(
                      delay: 350.milliseconds,
                      begin: Offset(0.0, 0.0),
                      end: Offset(1.0, 1.0),
                    ),
                  ],
                  child: FloatingActionButton(
                    heroTag: 'favorite',
                    tooltip: 'Favorite',
                    onPressed: () {
                      context.read<NewCoffeeImageBloc>().favoriteNewCoffeeImage(
                            state.image,
                          );
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
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
        buildWhen: (previous, current) => current is! NewCoffeeImageFavorited,
        builder: (context, state) {
          if (state is NewCoffeeImageInitial ||
              state is NewCoffeeImageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NewCoffeeImageLoaded) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Animate(
                effects: [
                  FlipEffect(
                    duration: 300.milliseconds,
                    direction: Axis.horizontal,
                  ),
                ],
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: BlendCardImage(
                    bytecode: state.image.fileEncoded,
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
