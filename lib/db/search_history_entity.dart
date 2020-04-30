/**
 *  Author:GasolZhang
 *  Date:2020-03-19
 */

import 'package:floor/floor.dart';

///
@entity
class SearchHistoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;
  @ColumnInfo(nullable: false)
  final String keyWord;

  SearchHistoryEntity({this.id, this.keyWord});
}
