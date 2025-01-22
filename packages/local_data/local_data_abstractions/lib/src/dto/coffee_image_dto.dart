import 'dart:typed_data';

class CoffeeImageDto {
  final String id;
  final Uint8List fileEncoded;

  CoffeeImageDto({
    required this.id,
    required this.fileEncoded,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoffeeImageDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fileEncoded == other.fileEncoded;

  @override
  int get hashCode => id.hashCode ^ fileEncoded.hashCode;
}
