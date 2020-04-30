/**
 *  Author:GasolZhang
 *  Date:2020-03-29
 */

import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/network/dio_util.dart';

import 'cart_goods_model.dart';
import 'cart_page.dart';

///
class CartPresenter extends BasePresenter<CartState> {
  void fetchGoods({int pageIndex = 1}) {
//    DioUtil.doRequest<CartGoodsModel>(Method.GET, '',
//        params: {'page_index': pageIndex},
//        onSuccess: (model) {},
//        onError: () {},
//        cancelToken: cancelToken);

    List<CartGoodsModel> models = [];
    for (int i = 0; i < 10; i++) {
      CartGoodsModel model = CartGoodsModel(
          id: '$i',
          shop: '瓦塔诺旗舰店',
          image:
              'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1755723003,1527359502&fm=26&gp=0.jpg',
          title: '瓦诺塔服装',
          specs: '卡其色，M(95-105斤)',
          price: '199.99',
          count: 1);
      models.add(model);
    }

    if (pageIndex == 1) {
      v.onFetchSuccess(models);
    } else {
      v.onLoadSuccess(pageIndex, models);
    }
  }

  void loadMoreGoods(int pageIndex) {
    fetchGoods(pageIndex: pageIndex);
  }
}
