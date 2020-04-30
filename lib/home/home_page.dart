import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/router.dart';
import 'package:jingdong/utils/list_util.dart';
import 'package:jingdong/utils/log_utl.dart' as MyLog;
import 'package:jingdong/widget/fake_search_app_bar.dart';
import 'package:jingdong/widget/state_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'home_banner_model.dart';
import 'home_guess_model.dart';
import 'home_list_model.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomePage, HomePresenter>
    with AutomaticKeepAliveClientMixin<HomePage> {
  List<BannerListBean> _bannerList;
  List<GuessListBean> _guessList;
  List<GoodsListBean> _recommandList = [];
  int _pageIndex = 1;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    fetchThrehold = 3;
    fetchAllDatas();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: FakeSearchAppBar(scanCallback: (result) {
          Fluttertoast.showToast(msg: '扫码结果$result}');
        }),
        body: getBody());
  }

  void fetchAllDatas() {
    fetchCount = 0;
    presenter.fetchBanner();
    presenter.fetchGuess();
    presenter.fetchRecommand();
  }

  Widget getBody() {
    return SmartRefresher(
        enablePullUp: showState == ShowState.NORMAL,
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: showState == ShowState.NORMAL
            ? ListView(shrinkWrap: true, children: <Widget>[
                _getBanner(),
                getHotTitle(),
                _getGuess(),
                getRecommandTitle(),
                _getStaggerdGridView(),
              ])
            : StateView(state: showState));
  }

  void _onRefresh() {
    fetchAllDatas();
  }

  void _onLoading() {
    presenter.fetchRecommand(pageIndex: _pageIndex + 1);
  }

  @override
  HomePresenter newPresenter() {
    return HomePresenter();
  }

  Widget _getBanner() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Swiper(
          itemCount: _bannerList?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ROUTER_GALLERY, arguments: {
                  'images': [_bannerList[index].Image],
                  'initalIndex': index
                });
              },
              child: CachedNetworkImage(
                imageUrl: _bannerList[index].Image,
                fit: BoxFit.cover,
              ),
            );
          },
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(size: 5, activeSize: 5))),
    );
  }

  Widget getHotTitle() {
    return Container(
        margin: EdgeInsets.only(left: 10, top: 10),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border:
                Border(left: BorderSide(width: 5, color: MyColors.primary))),
        child: Text('猜你喜欢',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)));
  }

  Widget _getGuess() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, ROUTER_GOODS_DETAIL,
                  arguments: {'goods_id': _guessList[index].GoodsId});
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(children: <Widget>[
                CachedNetworkImage(
                  imageUrl: _guessList[index].Image,
                  width: 60,
                  height: 60,
                ),
                SizedBox(height: 5),
                Text(
                  "¥ ${_guessList[index].Price}",
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                )
              ]),
            ),
          );
        },
        itemCount: _guessList?.length ?? 0,
      ),
    );
  }

  Widget getRecommandTitle() {
    return Container(
        margin: EdgeInsets.only(left: 10, top: 10),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border:
                Border(left: BorderSide(width: 5, color: MyColors.primary))),
        child: Text('热门推荐',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)));
  }

  Widget getRecommand() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: List.generate(_recommandList.length, (index) {
          return getRecommandItem(_recommandList[index]);
        }),
      ),
    );
  }

  Widget _getStaggerdGridView() {
    return StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.all(10),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: _recommandList?.length,
        itemBuilder: (context, index) {
          return getRecommandItem(_recommandList[index]);
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(2));
  }

  Widget getRecommandItem(GoodsListBean bean) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ROUTER_GOODS_DETAIL,
            arguments: {'goods_id': bean.ID});
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.light_gray, width: 1)),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: bean.Cover,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 5,
            ),
            Text(bean.Name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12)),
            SizedBox(height: 5),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¥ ${bean.Price}',
                    style: TextStyle(
                        color: MyColors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('¥ ${bean.OldPrice}',
                      style: TextStyle(
                          color: MyColors.light_gray,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onFetchBanner(List<BannerListBean> datas) {
    _bannerList = datas;
    fetchCount++;
    tryShowNormal();
  }

  void onFetchHot(List<GuessListBean> datas) {
    _guessList = datas;
    fetchCount++;
    tryShowNormal();
  }

  void onFetchList(List<GoodsListBean> datas, int pageIndex) {
    _recommandList = datas;
    _pageIndex = pageIndex;
    fetchCount++;
    tryShowNormal();
  }

  void onFetchError() {
    _refreshController.refreshFailed();
    if (ListUtil.isEmpty(_bannerList) ||
        ListUtil.isEmpty(_guessList) ||
        ListUtil.isEmpty(_recommandList)) {
      showError();
    } else {
      tryShowNormal();
    }
  }

  void onLoadList(List<GoodsListBean> datas, int pageIndex) {
    if (ListUtil.isEmpty(datas)) {
      _refreshController.loadNoData();
      return;
    }
    _pageIndex = pageIndex;
    _recommandList.addAll(datas);
    tryShowNormal();
  }

  void onLoadError() {
    _refreshController.loadFailed();
  }

  @override
  void tryShowNormal() {
    if (fetchCount >= fetchThrehold) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }
    super.tryShowNormal();
  }

  @override
  bool get wantKeepAlive => true;
}
