import 'package:blend/blend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/coffee_image.dart';
import 'cubit/image_details_cubit.dart';
import 'cubit/image_details_state.dart';

class ImageDetailsPage extends StatelessWidget {
  final CoffeeImage image;

  const ImageDetailsPage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageDetailsBloc(context.read())..loadImageDetails(image),
      child: _ImageDetailsPage(),
    );
  }
}

class _ImageDetailsPage extends StatefulWidget {
  const _ImageDetailsPage();

  @override
  State<_ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<_ImageDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<ImageDetailsBloc, ImageDetailsState>(
        builder: (context, state) {
          return switch (state) {
            ImageDetailsInitial() || ImageDetailsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ImageDetailsLoaded(image: final image) ||
            ImageDetailsSetAsBackground(image: final image) ||
            ImageDetailsRemoveFromFavorites(image: final image) =>
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.red[200],
                    tooltip: 'Remove from favorites',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Remove from favorites'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                context
                                    .read<ImageDetailsBloc>()
                                    .removeFromFavorites(
                                      image,
                                    );
                              },
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 32),
                  FloatingActionButton(
                    backgroundColor: Colors.blue[200],
                    tooltip: 'Set as background',
                    heroTag: 'set_as_background',
                    onPressed: () {
                      context.read<ImageDetailsBloc>().setAsBackground(image);
                    },
                    child: const Icon(Icons.photo_camera_back_outlined),
                  ),
                ],
              )
          };
        },
      ),
      body: BlocConsumer<ImageDetailsBloc, ImageDetailsState>(
        listener: (context, state) {
          if (state is ImageDetailsSetAsBackground) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Set as background'),
              ),
            );
          }
          if (state is ImageDetailsRemoveFromFavorites) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites'),
              ),
            );
            Navigator.pop(context);
          }
        },
        buildWhen: (previous, current) =>
            current is! ImageDetailsSetAsBackground &&
            current is! ImageDetailsRemoveFromFavorites,
        builder: (context, state) {
          if (state is ImageDetailsInitial || state is ImageDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ImageDetailsLoaded) {
            return Container(
              padding: const EdgeInsets.all(32.0),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: BlendCardImage(bytecode: state.image.fileEncoded),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
