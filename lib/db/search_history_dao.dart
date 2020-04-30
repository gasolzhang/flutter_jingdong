import 'package:floor/floor.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-19
 */

import 'package:jingdong/db/search_history_entity.dart';

///
@dao
abstract class SearchHistoryDao {
  @Query('SELECT * FROM SearchHistoryEntity ORDER BY id DESC')
  Future<List<SearchHistoryEntity>> findAll();

  @Query('SELECT DISTINCT keyWord FROM SearchHistoryEntity ORDER BY id DESC LIMIT 10')
  Stream<List<SearchHistoryEntity>> findAllAsStream();

  @insert
  Future<void> insertSingle(SearchHistoryEntity entity);

  @update
  Future<void> updateSingle(SearchHistoryEntity entity);

  @delete
  Future<void> deleteSingle(SearchHistoryEntity entity);

  @delete
  Future<void> deleteMulti(List<SearchHistoryEntity> entities);

  @Query('DELETE FROM SearchHistoryEntity')
  Future<void> clear();
}
