import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'coffee_database.g.dart';

@DataClassName('BackgroundCoffeeImage')
class BackgroundCoffeeImages extends Table {
  TextColumn get id => text()();
  BlobColumn get fileEncoded => blob()();
}

@DataClassName('CoffeeImage')
class CoffeeImages extends Table {
  TextColumn get id => text()();
  BlobColumn get fileEncoded => blob()();
}

@DriftDatabase(tables: [
  BackgroundCoffeeImages,
  CoffeeImages,
])
class CoffeeDatabase extends _$CoffeeDatabase {
  CoffeeDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'coffee_database',
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }

  Future<List<CoffeeImage>> get allCoffeeImages => select(coffeeImages).get();

  Future<void> insertCoffeeImage(CoffeeImage coffeeImage) async {
    await into(coffeeImages).insert(coffeeImage);
  }

  Future<void> deleteCoffeeImage(CoffeeImage coffeeImage) async {
    await coffeeImages.deleteWhere((tbl) => tbl.id.equals(coffeeImage.id));
  }

  Future<List<BackgroundCoffeeImage>> get allBackgroundCoffeeImages =>
      select(backgroundCoffeeImages).get();

  Future<void> insertBackgroundCoffeeImage(
      BackgroundCoffeeImage backgroundCoffeeImage) async {
    await into(backgroundCoffeeImages).insert(backgroundCoffeeImage);
  }

  Future<void> deleteBackgroundCoffeeImage(
      BackgroundCoffeeImage backgroundCoffeeImage) async {
    await backgroundCoffeeImages
        .deleteWhere((tbl) => tbl.id.equals(backgroundCoffeeImage.id));
  }
}
