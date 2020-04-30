import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/cart/cart_app_bar.dart';
import 'package:jingdong/cart/cart_goods_model.dart';
import 'package:jingdong/cart/cart_list_item.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/utils/list_util.dart';
import 'package:jingdong/widget/state_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'cart_presenter.dart';
import 'cart_state_provider.dart';
import 'cart_total_bar.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartState();
  }
}

class CartState extends BaseState<CartPage, CartPresenter>
    with AutomaticKeepAliveClientMixin<CartPage> {
  List<CartGoodsModel> models;
  RefreshController _controller = RefreshController();

  @override
  void initState() {
    super.initState();
    presenter.fetchGoods();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool needBack = ModalRoute.of(context).settings.arguments ?? false;
    return Scaffold(
        appBar: CartAppBar(needBack: needBack),
        body: Column(
          children: <Widget>[_getListView(), CartTotalBar()],
        ));
  }

  Widget _getListView() {
    return Expanded(
        child: SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: _controller,
      onLoading: onLoading,
      child: showState == ShowState.NORMAL
          ? ListView.builder(
              itemCount: models?.length,
              itemBuilder: (context, index) {
                return CartListItem(
                  model: models[index],
                );
              })
          : StateView(state: showState),
    ));
  }

  void onLoading() {
    presenter.loadMoreGoods(pageIndex + 1);
  }

  @override
  CartPresenter newPresenter() {
    return CartPresenter();
  }

  @override
  bool get wantKeepAlive => true;

  void onFetchSuccess(List<CartGoodsModel> models) {
    this.models = models;
    pageIndex = 1;
    tryShowNormal();
  }

  void onFetchError() {
    showError();
  }

  void onLoadSuccess(int pageIndex, List<CartGoodsModel> models) {
    if (ListUtil.isEmpty(models)) {
      _controller.loadNoData();
      return;
    }
    this.pageIndex = pageIndex;
    this.models.addAll(models);
    _controller.loadComplete();
    tryShowNormal();
  }

  void onLoadFailed() {
    _controller.loadFailed();
  }
}
