import 'dart:async';

/**
 *  Author:GasolZhang
 *  Date:2020-03-19
 */

import 'package:floor/floor.dart';
import 'package:jingdong/db/search_history_dao.dart';
import 'package:jingdong/db/search_history_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'database.g.dart'; // the generated code will be there

///
@Database(version: 1, entities: [SearchHistoryEntity])
abstract class AppDatabase extends FloorDatabase {
  SearchHistoryDao get searchHistoryDao;
}

class DBHelper {
  static AppDatabase appDatabase;

  static init() async {
    appDatabase =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
