import 'package:jingdong/db/database.dart';
import 'package:jingdong/db/search_history_dao.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/search/search_page.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-17
 */

///
class SearchPresenter extends BasePresenter<SearchState> {
  loadHistory() {
    return DBHelper.appDatabase.searchHistoryDao.findAllAsStream();
  }

  clearSearchHistory() async {
    SearchHistoryDao dao = DBHelper.appDatabase.searchHistoryDao;
    await dao.clear();
  }
}
