import 'package:flutter/cupertino.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/home/home_page.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/network/dio_util.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'home_banner_model.dart';
import 'home_guess_model.dart';
import 'home_list_model.dart';

class HomePresenter extends BasePresenter<HomeState> {
  void fetchBanner() {
    DioUtil.doRequest<HomeBannerModel>(Method.GET, UrlPath.HOME_BANNER,
        params: {"Limit": 4},
        onSuccess: (model) => v.onFetchBanner(model.Banner),
        onError: () => v.onFetchError(),
        cancelToken: cancelToken);
  }

  void fetchGuess() {
    DioUtil.doRequest<HomeGuessModel>(Method.GET, UrlPath.HOME_GUESS,
        params: {"Limit": 10},
        onSuccess: (model) => v.onFetchHot(model.Guess),
        onError: () => v.onFetchError(),
        cancelToken: cancelToken);
  }

  void fetchRecommand({int pageIndex = 1}) {
    DioUtil.doRequest<HomeListModel>(Method.GET, UrlPath.HOME_LIST,
        params: {'Page': pageIndex, 'Limit': 10},
        onSuccess: (model) {
          pageIndex == 1
              ? v.onFetchList(model.Goods, pageIndex)
              : v.onLoadList(model.Goods, pageIndex);
        },
        onError: () => v.onLoadError(),
        cancelToken: cancelToken);
  }

  void loadMoreRecommand({@required int pageIndex}) {
    fetchRecommand(pageIndex: pageIndex);
  }
}
