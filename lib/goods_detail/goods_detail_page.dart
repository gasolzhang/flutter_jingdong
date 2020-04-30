/**
 *  Author:GasolZhang
 *  Date:2020-03-21
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/goods_detail/goods_child_page.dart';
import 'package:jingdong/goods_detail/goods_detail_app_bar.dart';
import 'package:jingdong/goods_detail/goods_detail_web_page.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/res.dart';
import 'package:jingdong/widget/jd_button.dart';
import 'goods_detail_presenter.dart';

///
class GoodsDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoodsDetailState();
  }
}

class GoodsDetailState extends BaseState<GoodsDetailPage, GoodsDetailPresenter>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  String _goodsId;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      _goodsId = arguments['goods_id'];
    }

    return Scaffold(
      appBar: GoodsDetailAppBar(tabController: _controller),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(controller: _controller, children: <Widget>[
              getGoodsChildPage(),
              getDetailChildPage(),
              getCommentChildPage()
            ]),
          ),
          _getBottomFloatBar(),
        ],
      ),
    );
  }

  Widget getGoodsChildPage() {
    return GoodsChildPage();
  }

  Widget getDetailChildPage() {
    return GoodsDetailWebPage(goodsId: _goodsId);
  }

  Widget getCommentChildPage() {
    return Container(child: Center(child: Text('商品评论子页')));
  }

  Widget _getBottomFloatBar() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey[300], spreadRadius: 1, blurRadius: 1)
        ]),
        child: Row(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.shopping_cart), Text('购物车')],
          ),
          Expanded(child: Text('')),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: JDButton(
                text: '加入购物车',
                bgColor: Colors.orange,
                onTap: () {
                  Fluttertoast.showToast(msg: '执行加入购物车');
                }),
          ),
          JDButton(
            text: '立即购买',
            bgColor: MyColors.primary,
            onTap: () {
              Fluttertoast.showToast(msg: '执行立即购买');
            },
          )
        ]));
  }

  @override
  GoodsDetailPresenter newPresenter() {
    return GoodsDetailPresenter();
  }
}
