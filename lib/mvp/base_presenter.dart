import 'package:dio/dio.dart';
import 'package:jingdong/mvp/i_view.dart';
import 'package:jingdong/utils/log_utl.dart';

abstract class BasePresenter<V extends IView> {
  V v;
  CancelToken cancelToken;

  void attachView(V v) {
    this.v = v;
    cancelToken = CancelToken();
  }

  void dispose() {
    try {
      cancelToken.cancel('页面关闭');
    } catch (e) {
      LogUtil.w('取消网络请求$e');
    }

    v = null;
  }
}
