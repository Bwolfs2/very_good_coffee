import 'package:flutter/foundation.dart';

class CoffeeImage {
  final Uint8List bytecode;
  final DateTime generatedAt;

  const CoffeeImage({
    required this.bytecode,
    required this.generatedAt,
  });
}
