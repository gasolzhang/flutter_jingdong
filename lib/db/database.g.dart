// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SearchHistoryDao _searchHistoryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SearchHistoryEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `keyWord` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  SearchHistoryDao get searchHistoryDao {
    return _searchHistoryDaoInstance ??=
        _$SearchHistoryDao(database, changeListener);
  }
}

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _searchHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'SearchHistoryEntity',
            (SearchHistoryEntity item) =>
                <String, dynamic>{'id': item.id, 'keyWord': item.keyWord},
            changeListener),
        _searchHistoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'SearchHistoryEntity',
            ['id'],
            (SearchHistoryEntity item) =>
                <String, dynamic>{'id': item.id, 'keyWord': item.keyWord},
            changeListener),
        _searchHistoryEntityDeletionAdapter = DeletionAdapter(
            database,
            'SearchHistoryEntity',
            ['id'],
            (SearchHistoryEntity item) =>
                <String, dynamic>{'id': item.id, 'keyWord': item.keyWord},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _searchHistoryEntityMapper = (Map<String, dynamic> row) =>
      SearchHistoryEntity(
          id: row['id'] as int, keyWord: row['keyWord'] as String);

  final InsertionAdapter<SearchHistoryEntity>
      _searchHistoryEntityInsertionAdapter;

  final UpdateAdapter<SearchHistoryEntity> _searchHistoryEntityUpdateAdapter;

  final DeletionAdapter<SearchHistoryEntity>
      _searchHistoryEntityDeletionAdapter;

  @override
  Future<List<SearchHistoryEntity>> findAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM SearchHistoryEntity ORDER BY id DESC',
        mapper: _searchHistoryEntityMapper);
  }

  @override
  Stream<List<SearchHistoryEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT DISTINCT keyWord FROM SearchHistoryEntity ORDER BY id DESC LIMIT 10',
        tableName: 'SearchHistoryEntity',
        mapper: _searchHistoryEntityMapper);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SearchHistoryEntity');
  }

  @override
  Future<void> insertSingle(SearchHistoryEntity entity) async {
    await _searchHistoryEntityInsertionAdapter.insert(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateSingle(SearchHistoryEntity entity) async {
    await _searchHistoryEntityUpdateAdapter.update(
        entity, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteSingle(SearchHistoryEntity entity) async {
    await _searchHistoryEntityDeletionAdapter.delete(entity);
  }

  @override
  Future<void> deleteMulti(List<SearchHistoryEntity> entities) async {
    await _searchHistoryEntityDeletionAdapter.deleteList(entities);
  }
}
