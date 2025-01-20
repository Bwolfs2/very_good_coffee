import 'package:blend/blend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

import 'bloc/image_details_bloc.dart';
import 'bloc/image_details_event.dart';
import 'bloc/image_details_state.dart';

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
          ImageDetailsBloc(context.read())..add(ImageDetailsLoadEvent(image)),
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
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites'),
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            ImageDetailsInitial() || ImageDetailsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ImageDetailsLoaded(image: final image) ||
            ImageDetailsSetAsBackground(image: final image) ||
            ImageDetailsRemoveFromFavorites(image: final image) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: MediaQuery.sizeOf(context).width,
                      child: BlendCardImage(bytecode: image.fileEncoded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context.read<ImageDetailsBloc>().add(
                                    ImageDetailsRemoveFromFavoritesEvent(image),
                                  );
                            },
                            child: FittedBox(
                                child: const Text('Remove from favorites')),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context.read<ImageDetailsBloc>().add(
                                    ImageDetailsSetAsBackgroundEvent(image),
                                  );
                            },
                            child: FittedBox(
                                child: const Text('Set as Background')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
