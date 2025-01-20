import 'package:flutter/foundation.dart';

class CoffeeImage {
  final String id;
  final Uint8List fileEncoded;

  const CoffeeImage({
    required this.id,
    required this.fileEncoded,
  });
}
