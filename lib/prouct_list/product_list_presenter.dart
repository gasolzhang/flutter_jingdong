import 'package:flutter/cupertino.dart';
import 'package:jingdong/db/database.dart';
import 'package:jingdong/db/search_history_entity.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/mvp/product_list_model.dart';
import 'package:jingdong/prouct_list/product_list_page.dart';
import 'package:jingdong/utils/log_utl.dart';

class ProductListPresenter extends BasePresenter<ProductListState> {
  void fetchProducts(
      {String cateId, String keyWord, int pageIndex = 1, int order = 0}) {
//    DioUtil.doRequest<ProductListModel>(Method.GET, UrlPath.PRODUCT_CATE_LIST,
//        params: {
//          'cate_id': cateId,
//          'page_index': pageIndex,
//          'limit': 20,
//          'order': order
//        }, onSuccess: (model) {
//      if (model.pageIndex == 1) {
//        v.onFetchProductDatas(model);
//      } else {
//        v.onLoadMoreProductDatas(model);
//      }
//    }, onError: () {
//      if (pageIndex == 1) {
//        v.onFetchError();
//      } else {
//        v.onLoadMoreError();
//      }
//    });
    //将搜索记录存入数据库
    SearchHistoryEntity entity = SearchHistoryEntity(keyWord: keyWord);
    DBHelper.appDatabase.searchHistoryDao.insertSingle(entity);
    LogUtil.d('存入搜索记录:$keyWord');

    ProductListModel model = ProductListModel();
    model.total = 100;
    model.pageIndex = pageIndex;
    print('pageIndex:$pageIndex');

    List<DatasListBean> datas = [];
    for (int i = 0; i < 20; i++) {
      DatasListBean bean = DatasListBean(
          id: i.toString(),
          cateId: cateId,
          image:
              'http://d.hiphotos.baidu.com/zhidao/pic/item/6f061d950a7b020850edff8860d9f2d3572cc8b7.jpg',
          title: '第${(pageIndex - 1) * 20 + i}项 内有恶犬，十分凶萌，小心购买，后果自负',
          price: '¥ 1999',
          tags: ['宠物', '狗子']);
      datas.add(bean);
    }
    model.datas = datas;

    if (pageIndex == 1) {
      v.onFetchProductDatas(model);
    } else {
      v.onLoadMoreProductDatas(model);
    }
  }

  void loadMoreProducts(
      {String cateId, String keyWord, @required int pageIndex, int order = 0}) {
    fetchProducts(
        cateId: cateId, keyWord: keyWord, pageIndex: pageIndex, order: order);
  }
}
