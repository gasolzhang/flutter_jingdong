import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/goods_detail/goods_spec_header_model.dart';
import 'package:jingdong/home/home_banner_model.dart';
import 'package:jingdong/home/home_guess_model.dart';
import 'package:jingdong/home/home_list_model.dart';
import 'package:jingdong/mvp/product_list_model.dart';
import 'package:jingdong/user/user_model.dart';

class ModelFactory {
  static T createModel<T>(json) {
    String modelName = T.toString();

    try {
      if (modelName == UserModel().runtimeType.toString()) {
        return UserModel.fromJson(json) as T;
      }

      if (modelName == HomeBannerModel().runtimeType.toString()) {
        return HomeBannerModel.fromJson(json) as T;
      }

      if (modelName == HomeGuessModel().runtimeType.toString()) {
        return HomeGuessModel.fromJson(json) as T;
      }

      if (modelName == HomeListModel().runtimeType.toString()) {
        return HomeListModel.fromJson(json) as T;
      }

      if (modelName == ProductListModel().runtimeType.toString()) {
        return ProductListModel.fromJson(json) as T;
      }

      if (modelName == GoodsSpecHeaderModel().runtimeType.toString()) {
        return GoodsSpecHeaderModel.fromJson(json) as T;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '请求结果解析异常');
      print('请求结果解析异常：$e');
    }
    return null;
  }
}
