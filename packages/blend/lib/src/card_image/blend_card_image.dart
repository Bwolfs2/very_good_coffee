import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlendCardImage extends StatelessWidget {
  final Uint8List bytecode;
  const BlendCardImage({super.key, required this.bytecode});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 8,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.memory(
          bytecode,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
