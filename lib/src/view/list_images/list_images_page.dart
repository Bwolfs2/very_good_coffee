import 'package:blend/blend.dart';
import 'package:flutter/material.dart';

import '../../domain/model/coffee_image.dart';

class ListImagesPage extends StatefulWidget {
  const ListImagesPage({super.key});

  @override
  State<ListImagesPage> createState() => _ListImagesPageState();
}

class _ListImagesPageState extends State<ListImagesPage> {
  bool isGridView = false;

  late final PageController _pageController;
  double _currentPage = 5000000;
  final value = 10000000;
  final midleValue = 5000000;
  late final ValueNotifier<double> controller =
      ValueNotifier<double>(midleValue * 1.0);

  final ValueNotifier<double> valueController = ValueNotifier<double>(0);

  final images = <CoffeeImage> [
    
  ];

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: midleValue, viewportFraction: .8);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

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
      body: isGridView
          ? GridView.builder(
              itemCount: images.length,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
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
                      arguments: images[index],
                    );
                  },
                  child: BlendCardImage(
                    bytecode: images[index % images.length].bytecode,
                  ),
                );
              })
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 32.0),
              height: 400,
              width: MediaQuery.sizeOf(context).width,
              child: PageView.builder(
                clipBehavior: Clip.none,
                itemCount: value,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder(
                      valueListenable: valueController,
                      builder: (context, value, child) {
                        final image = images[index % images.length];

                        return AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return child!;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/image_details',
                                  arguments: image,
                                );
                              },
                              child: BlendCardImage(
                                bytecode: image.bytecode,
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
    );
  }
}
