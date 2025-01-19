import 'package:blend/blend.dart';
import 'package:flutter/material.dart';
import 'package:very_good_coffee/src/domain/model/coffee_image.dart';

class ImageDetailsPage extends StatefulWidget {
  final CoffeeImage image;

  const ImageDetailsPage({
    super.key,
    required this.image,
  });

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 500,
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.sizeOf(context).width,
                child: BlendCardImage(bytecode: widget.image.bytecode),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite, color: Colors.white),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Set as Background'),
          ),
        ],
      ),
    );
  }
}
