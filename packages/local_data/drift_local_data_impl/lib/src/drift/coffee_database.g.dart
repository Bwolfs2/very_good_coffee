// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_database.dart';

// ignore_for_file: type=lint
class $BackgroundCoffeeImagesTable extends BackgroundCoffeeImages
    with TableInfo<$BackgroundCoffeeImagesTable, BackgroundCoffeeImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackgroundCoffeeImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileEncodedMeta =
      const VerificationMeta('fileEncoded');
  @override
  late final GeneratedColumn<Uint8List> fileEncoded =
      GeneratedColumn<Uint8List>('file_encoded', aliasedName, false,
          type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, fileEncoded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'background_coffee_images';
  @override
  VerificationContext validateIntegrity(
      Insertable<BackgroundCoffeeImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('file_encoded')) {
      context.handle(
          _fileEncodedMeta,
          fileEncoded.isAcceptableOrUnknown(
              data['file_encoded']!, _fileEncodedMeta));
    } else if (isInserting) {
      context.missing(_fileEncodedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BackgroundCoffeeImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackgroundCoffeeImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fileEncoded: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}file_encoded'])!,
    );
  }

  @override
  $BackgroundCoffeeImagesTable createAlias(String alias) {
    return $BackgroundCoffeeImagesTable(attachedDatabase, alias);
  }
}

class BackgroundCoffeeImage extends DataClass
    implements Insertable<BackgroundCoffeeImage> {
  final String id;
  final Uint8List fileEncoded;
  const BackgroundCoffeeImage({required this.id, required this.fileEncoded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['file_encoded'] = Variable<Uint8List>(fileEncoded);
    return map;
  }

  BackgroundCoffeeImagesCompanion toCompanion(bool nullToAbsent) {
    return BackgroundCoffeeImagesCompanion(
      id: Value(id),
      fileEncoded: Value(fileEncoded),
    );
  }

  factory BackgroundCoffeeImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackgroundCoffeeImage(
      id: serializer.fromJson<String>(json['id']),
      fileEncoded: serializer.fromJson<Uint8List>(json['fileEncoded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fileEncoded': serializer.toJson<Uint8List>(fileEncoded),
    };
  }

  BackgroundCoffeeImage copyWith({String? id, Uint8List? fileEncoded}) =>
      BackgroundCoffeeImage(
        id: id ?? this.id,
        fileEncoded: fileEncoded ?? this.fileEncoded,
      );
  BackgroundCoffeeImage copyWithCompanion(
      BackgroundCoffeeImagesCompanion data) {
    return BackgroundCoffeeImage(
      id: data.id.present ? data.id.value : this.id,
      fileEncoded:
          data.fileEncoded.present ? data.fileEncoded.value : this.fileEncoded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundCoffeeImage(')
          ..write('id: $id, ')
          ..write('fileEncoded: $fileEncoded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(fileEncoded));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackgroundCoffeeImage &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.fileEncoded, this.fileEncoded));
}

class BackgroundCoffeeImagesCompanion
    extends UpdateCompanion<BackgroundCoffeeImage> {
  final Value<String> id;
  final Value<Uint8List> fileEncoded;
  final Value<int> rowid;
  const BackgroundCoffeeImagesCompanion({
    this.id = const Value.absent(),
    this.fileEncoded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackgroundCoffeeImagesCompanion.insert({
    required String id,
    required Uint8List fileEncoded,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fileEncoded = Value(fileEncoded);
  static Insertable<BackgroundCoffeeImage> custom({
    Expression<String>? id,
    Expression<Uint8List>? fileEncoded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileEncoded != null) 'file_encoded': fileEncoded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackgroundCoffeeImagesCompanion copyWith(
      {Value<String>? id, Value<Uint8List>? fileEncoded, Value<int>? rowid}) {
    return BackgroundCoffeeImagesCompanion(
      id: id ?? this.id,
      fileEncoded: fileEncoded ?? this.fileEncoded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fileEncoded.present) {
      map['file_encoded'] = Variable<Uint8List>(fileEncoded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundCoffeeImagesCompanion(')
          ..write('id: $id, ')
          ..write('fileEncoded: $fileEncoded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoffeeImagesTable extends CoffeeImages
    with TableInfo<$CoffeeImagesTable, CoffeeImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileEncodedMeta =
      const VerificationMeta('fileEncoded');
  @override
  late final GeneratedColumn<Uint8List> fileEncoded =
      GeneratedColumn<Uint8List>('file_encoded', aliasedName, false,
          type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, fileEncoded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_images';
  @override
  VerificationContext validateIntegrity(Insertable<CoffeeImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('file_encoded')) {
      context.handle(
          _fileEncodedMeta,
          fileEncoded.isAcceptableOrUnknown(
              data['file_encoded']!, _fileEncodedMeta));
    } else if (isInserting) {
      context.missing(_fileEncodedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CoffeeImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fileEncoded: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}file_encoded'])!,
    );
  }

  @override
  $CoffeeImagesTable createAlias(String alias) {
    return $CoffeeImagesTable(attachedDatabase, alias);
  }
}

class CoffeeImage extends DataClass implements Insertable<CoffeeImage> {
  final String id;
  final Uint8List fileEncoded;
  const CoffeeImage({required this.id, required this.fileEncoded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['file_encoded'] = Variable<Uint8List>(fileEncoded);
    return map;
  }

  CoffeeImagesCompanion toCompanion(bool nullToAbsent) {
    return CoffeeImagesCompanion(
      id: Value(id),
      fileEncoded: Value(fileEncoded),
    );
  }

  factory CoffeeImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeImage(
      id: serializer.fromJson<String>(json['id']),
      fileEncoded: serializer.fromJson<Uint8List>(json['fileEncoded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fileEncoded': serializer.toJson<Uint8List>(fileEncoded),
    };
  }

  CoffeeImage copyWith({String? id, Uint8List? fileEncoded}) => CoffeeImage(
        id: id ?? this.id,
        fileEncoded: fileEncoded ?? this.fileEncoded,
      );
  CoffeeImage copyWithCompanion(CoffeeImagesCompanion data) {
    return CoffeeImage(
      id: data.id.present ? data.id.value : this.id,
      fileEncoded:
          data.fileEncoded.present ? data.fileEncoded.value : this.fileEncoded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeImage(')
          ..write('id: $id, ')
          ..write('fileEncoded: $fileEncoded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(fileEncoded));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeImage &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.fileEncoded, this.fileEncoded));
}

class CoffeeImagesCompanion extends UpdateCompanion<CoffeeImage> {
  final Value<String> id;
  final Value<Uint8List> fileEncoded;
  final Value<int> rowid;
  const CoffeeImagesCompanion({
    this.id = const Value.absent(),
    this.fileEncoded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeImagesCompanion.insert({
    required String id,
    required Uint8List fileEncoded,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fileEncoded = Value(fileEncoded);
  static Insertable<CoffeeImage> custom({
    Expression<String>? id,
    Expression<Uint8List>? fileEncoded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileEncoded != null) 'file_encoded': fileEncoded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeImagesCompanion copyWith(
      {Value<String>? id, Value<Uint8List>? fileEncoded, Value<int>? rowid}) {
    return CoffeeImagesCompanion(
      id: id ?? this.id,
      fileEncoded: fileEncoded ?? this.fileEncoded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fileEncoded.present) {
      map['file_encoded'] = Variable<Uint8List>(fileEncoded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeImagesCompanion(')
          ..write('id: $id, ')
          ..write('fileEncoded: $fileEncoded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CoffeeDatabase extends GeneratedDatabase {
  _$CoffeeDatabase(QueryExecutor e) : super(e);
  $CoffeeDatabaseManager get managers => $CoffeeDatabaseManager(this);
  late final $BackgroundCoffeeImagesTable backgroundCoffeeImages =
      $BackgroundCoffeeImagesTable(this);
  late final $CoffeeImagesTable coffeeImages = $CoffeeImagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [backgroundCoffeeImages, coffeeImages];
}

typedef $$BackgroundCoffeeImagesTableCreateCompanionBuilder
    = BackgroundCoffeeImagesCompanion Function({
  required String id,
  required Uint8List fileEncoded,
  Value<int> rowid,
});
typedef $$BackgroundCoffeeImagesTableUpdateCompanionBuilder
    = BackgroundCoffeeImagesCompanion Function({
  Value<String> id,
  Value<Uint8List> fileEncoded,
  Value<int> rowid,
});

class $$BackgroundCoffeeImagesTableFilterComposer
    extends Composer<_$CoffeeDatabase, $BackgroundCoffeeImagesTable> {
  $$BackgroundCoffeeImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get fileEncoded => $composableBuilder(
      column: $table.fileEncoded, builder: (column) => ColumnFilters(column));
}

class $$BackgroundCoffeeImagesTableOrderingComposer
    extends Composer<_$CoffeeDatabase, $BackgroundCoffeeImagesTable> {
  $$BackgroundCoffeeImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get fileEncoded => $composableBuilder(
      column: $table.fileEncoded, builder: (column) => ColumnOrderings(column));
}

class $$BackgroundCoffeeImagesTableAnnotationComposer
    extends Composer<_$CoffeeDatabase, $BackgroundCoffeeImagesTable> {
  $$BackgroundCoffeeImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get fileEncoded => $composableBuilder(
      column: $table.fileEncoded, builder: (column) => column);
}

class $$BackgroundCoffeeImagesTableTableManager extends RootTableManager<
    _$CoffeeDatabase,
    $BackgroundCoffeeImagesTable,
    BackgroundCoffeeImage,
    $$BackgroundCoffeeImagesTableFilterComposer,
    $$BackgroundCoffeeImagesTableOrderingComposer,
    $$BackgroundCoffeeImagesTableAnnotationComposer,
    $$BackgroundCoffeeImagesTableCreateCompanionBuilder,
    $$BackgroundCoffeeImagesTableUpdateCompanionBuilder,
    (
      BackgroundCoffeeImage,
      BaseReferences<_$CoffeeDatabase, $BackgroundCoffeeImagesTable,
          BackgroundCoffeeImage>
    ),
    BackgroundCoffeeImage,
    PrefetchHooks Function()> {
  $$BackgroundCoffeeImagesTableTableManager(
      _$CoffeeDatabase db, $BackgroundCoffeeImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackgroundCoffeeImagesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$BackgroundCoffeeImagesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackgroundCoffeeImagesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<Uint8List> fileEncoded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BackgroundCoffeeImagesCompanion(
            id: id,
            fileEncoded: fileEncoded,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required Uint8List fileEncoded,
            Value<int> rowid = const Value.absent(),
          }) =>
              BackgroundCoffeeImagesCompanion.insert(
            id: id,
            fileEncoded: fileEncoded,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BackgroundCoffeeImagesTableProcessedTableManager
    = ProcessedTableManager<
        _$CoffeeDatabase,
        $BackgroundCoffeeImagesTable,
        BackgroundCoffeeImage,
        $$BackgroundCoffeeImagesTableFilterComposer,
        $$BackgroundCoffeeImagesTableOrderingComposer,
        $$BackgroundCoffeeImagesTableAnnotationComposer,
        $$BackgroundCoffeeImagesTableCreateCompanionBuilder,
        $$BackgroundCoffeeImagesTableUpdateCompanionBuilder,
        (
          BackgroundCoffeeImage,
          BaseReferences<_$CoffeeDatabase, $BackgroundCoffeeImagesTable,
              BackgroundCoffeeImage>
        ),
        BackgroundCoffeeImage,
        PrefetchHooks Function()>;
typedef $$CoffeeImagesTableCreateCompanionBuilder = CoffeeImagesCompanion
    Function({
  required String id,
  required Uint8List fileEncoded,
  Value<int> rowid,
});
typedef $$CoffeeImagesTableUpdateCompanionBuilder = CoffeeImagesCompanion
    Function({
  Value<String> id,
  Value<Uint8List> fileEncoded,
  Value<int> rowid,
});

class $$CoffeeImagesTableFilterComposer
    extends Composer<_$CoffeeDatabase, $CoffeeImagesTable> {
  $$CoffeeImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get fileEncoded => $composableBuilder(
      column: $table.fileEncoded, builder: (column) => ColumnFilters(column));
}

class $$CoffeeImagesTableOrderingComposer
    extends Composer<_$CoffeeDatabase, $CoffeeImagesTable> {
  $$CoffeeImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get fileEncoded => $composableBuilder(
      column: $table.fileEncoded, builder: (column) => ColumnOrderings(column));
}

class $$CoffeeImagesTableAnnotationComposer
    extends Composer<_$CoffeeDatabase, $CoffeeImagesTable> {
  $$CoffeeImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get fileEncoded => $composableBuilder(
      column: $table.fileEncoded, builder: (column) => column);
}

class $$CoffeeImagesTableTableManager extends RootTableManager<
    _$CoffeeDatabase,
    $CoffeeImagesTable,
    CoffeeImage,
    $$CoffeeImagesTableFilterComposer,
    $$CoffeeImagesTableOrderingComposer,
    $$CoffeeImagesTableAnnotationComposer,
    $$CoffeeImagesTableCreateCompanionBuilder,
    $$CoffeeImagesTableUpdateCompanionBuilder,
    (
      CoffeeImage,
      BaseReferences<_$CoffeeDatabase, $CoffeeImagesTable, CoffeeImage>
    ),
    CoffeeImage,
    PrefetchHooks Function()> {
  $$CoffeeImagesTableTableManager(_$CoffeeDatabase db, $CoffeeImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeeImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<Uint8List> fileEncoded = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CoffeeImagesCompanion(
            id: id,
            fileEncoded: fileEncoded,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required Uint8List fileEncoded,
            Value<int> rowid = const Value.absent(),
          }) =>
              CoffeeImagesCompanion.insert(
            id: id,
            fileEncoded: fileEncoded,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CoffeeImagesTableProcessedTableManager = ProcessedTableManager<
    _$CoffeeDatabase,
    $CoffeeImagesTable,
    CoffeeImage,
    $$CoffeeImagesTableFilterComposer,
    $$CoffeeImagesTableOrderingComposer,
    $$CoffeeImagesTableAnnotationComposer,
    $$CoffeeImagesTableCreateCompanionBuilder,
    $$CoffeeImagesTableUpdateCompanionBuilder,
    (
      CoffeeImage,
      BaseReferences<_$CoffeeDatabase, $CoffeeImagesTable, CoffeeImage>
    ),
    CoffeeImage,
    PrefetchHooks Function()>;

class $CoffeeDatabaseManager {
  final _$CoffeeDatabase _db;
  $CoffeeDatabaseManager(this._db);
  $$BackgroundCoffeeImagesTableTableManager get backgroundCoffeeImages =>
      $$BackgroundCoffeeImagesTableTableManager(
          _db, _db.backgroundCoffeeImages);
  $$CoffeeImagesTableTableManager get coffeeImages =>
      $$CoffeeImagesTableTableManager(_db, _db.coffeeImages);
}
