import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/network/dio_util.dart';
import 'goods_child_banner_model.dart';
import 'goods_child_info_model.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-24
 */

import 'goods_child_page.dart';

///
class GoodsChildPresenter extends BasePresenter<GoodsChildState> {
  void fetchBanner() {
//    DioUtil.doRequest<GoodsChildBannerModel>(
//        Method.GET, UrlPath.PRODUCT_DETAIL_BANNER, onSuccess: (model) {
//      v.onFetchBanner(model.images);
//    }, onError: () {});

    List<String> images = [
      'http://pic.netbian.com/uploads/allimg/200107/224043-1578408043d55d.jpg',
      'http://pic.netbian.com/uploads/allimg/180222/231102-151931226201f1.jpg',
      'http://pic.netbian.com/uploads/allimg/190614/221508-15605217086e6f.jpg'
    ];

    v.onFetchBanner(images);
  }

  void fetchInfo() {
//    DioUtil.doRequest<GoodsChildInfoModel>(
//        Method.GET, UrlPath.PRODUCT_DETAIL_INFO, onSuccess: (model) {
//      v.onFetchInfo(model);
//    }, onError: () {});

    GoodsChildInfoModel model = GoodsChildInfoModel(
        title: 'Apple 2019新品 MacBook Pro 16寸九代八核 i9 2.3/16G/1TB 笔记本电脑轻薄本【带触控栏】',
        info: 'Apple/苹果 2.3GHz 8 核处理器 1TB 存储容量 AMD Radeon Pro 5500M',
        price: '21299',
        oldPrice: '25299');
    v.onFetchInfo(model);
  }
}
