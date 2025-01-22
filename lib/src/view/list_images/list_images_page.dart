import 'package:blend/blend.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';
import 'package:very_good_coffee/src/view/list_images/cubit/list_images_cubit.dart';

import 'cubit/list_images_states.dart';

class ListImagesPage extends StatelessWidget {
  const ListImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListImagesCubit(context.read())..loadFavoritedCoffee(),
      child: const _ListImagesBody(),
    );
  }
}

class _ListImagesBody extends StatefulWidget {
  const _ListImagesBody();

  @override
  State<_ListImagesBody> createState() => _ListImagesBodyState();
}

class _ListImagesBodyState extends State<_ListImagesBody> {
  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Images'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isGridView = !isGridView;
          });
        },
        child: isGridView
            ? const Icon(Icons.width_full_outlined)
            : const Icon(Icons.grid_view),
      ),
      body: BlocConsumer<ListImagesCubit, ListImagesStates>(
        listener: (context, state) {
          if (state is ListImagesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red[100],
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            ListImagesInitial() =>
              const Center(child: CircularProgressIndicator()),
            ListImagesError() => Center(child: Text(state.message)),
            ListImagesLoaded(coffeeImages: final coffeeImages)
                when coffeeImages.isEmpty =>
              const Center(child: Text('No images found')),
            ListImagesLoaded(coffeeImages: final coffeeImages)
                when isGridView =>
              GridView.builder(
                  itemCount: coffeeImages.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 48.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/image_details',
                          arguments: coffeeImages[index],
                        );
                      },
                      child: BlendCardImage(
                        bytecode: coffeeImages[index % coffeeImages.length]
                            .fileEncoded,
                      ),
                    );
                  }),
            ListImagesLoaded(coffeeImages: final coffeeImages) => ClipRRect(
                child: Center(
                  child: SizedBox(
                    height: 400,
                    width: MediaQuery.sizeOf(context).width,
                    child: _PageView(images: coffeeImages),
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _PageView extends StatefulWidget {
  final List<CoffeeImage> images;
  const _PageView({required this.images});

  @override
  State<_PageView> createState() => __PageViewState();
}

class __PageViewState extends State<_PageView> {
  late final PageController _pageController;
  double _currentPage = 5000000;
  final value = 10000000;
  final midleValue = 5000000;
  late final ValueNotifier<double> controller =
      ValueNotifier<double>(midleValue * 1.0);

  final ValueNotifier<double> valueController = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: midleValue, viewportFraction: .7);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollBehavior: AppScrollBehavior(),
      clipBehavior: Clip.none,
      itemCount: value,
      controller: _pageController,
      itemBuilder: (context, index) {
        return ValueListenableBuilder(
            valueListenable: valueController,
            builder: (context, value, child) {
              final image = widget.images[index % widget.images.length];

              return AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..scale(1 - 0.2 * (index - _currentPage).abs()),
                    child: child!,
                  );
                },
                child: InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      '/image_details',
                      arguments: image,
                    );
                    if (context.mounted) {
                      context.read<ListImagesCubit>().loadFavoritedCoffee();
                    }
                  },
                  child: BlendCardImage(
                    bytecode: image.fileEncoded,
                  ),
                ),
              );
            });
      },
    );
  }
}
