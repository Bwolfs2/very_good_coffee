import 'dart:typed_data';

class CoffeeImageDto {
  final String id;
  final Uint8List fileEncoded;

  CoffeeImageDto({
    required this.id,
    required this.fileEncoded,
  });
}
