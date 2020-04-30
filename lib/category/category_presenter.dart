import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/network/dio_util.dart';

import 'category.dart';
import 'category_model.dart' as CM;
import 'category_seccond_model.dart' as CSM;

class CategoryPresenter extends BasePresenter<CategoryState> {
  void fetchCategories() {
//    DioUtil.doRequest<CM.CategoryModel>(Method.GET, UrlPath.CATEGORY_LIST,
//        onSuccess: (model) {
//      v.onFetchCategories(model.datas);
//    }, onError: () {
//      v.showError();
//    });

    List<CM.DatasListBean> datas = [];
    for (int i = 0; i < 20; i++) {
      CM.DatasListBean bean =
          CM.DatasListBean(id: i.toString(), name: '分类$i', type: 1);
      datas.add(bean);
    }
    v.onFetchCategories(datas);
  }

  void fetchSeccondCate(String parentId) {
//    DioUtil.doRequest<CSM.CategorySeccondModel>(
//        Method.GET, UrlPath.CATEGORY_SECCOND,
//        onSuccess: (model) {}, onError: () {});

    List<CSM.DatasListBean> datas = [];
    List<String> images = [
      'http://pic4.zhimg.com/50/v2-456c8ac5dae67147cc7304abe08f2bef_hd.jpg',
      'http://b-ssl.duitang.com/uploads/item/201812/10/20181210163023_xXazM.thumb.700_0.jpeg'
    ];
    for (int i = 0; i < 10; i++) {
      CSM.DatasListBean bean = CSM.DatasListBean(
          type: 2, id: i.toString(), image: images[i % 2], name: '种类$i');
      datas.add(bean);
    }

    v.onFetchSeccondCate(datas);
  }
}
