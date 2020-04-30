import 'package:flustars/flustars.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-21
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';

///
class GoodsDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  GoodsDetailAppBar({Key key, this.tabController}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors.primary,
        child: SafeArea(
            top: true,
            child: Stack(children: <Widget>[
              _getBackButton(context),
              _getTabBar(),
              _getAction(context)
            ])));
  }

  Widget _getBackButton(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ));
  }

  Widget _getTabBar() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          height: 30,
          width: 200,
          child: TabBar(
              tabs: _getTabs(),
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              controller: tabController,
              indicator: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white)))),
        ));
  }

  List<Tab> _getTabs() {
    Tab tab1 = Tab(text: '商品');
    Tab tab2 = Tab(text: '详情');
    Tab tab3 = Tab(text: '评论');
    return [tab1, tab2, tab3];
  }

  Widget _getAction(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            onPressed: () {
              showMore(context);
            },
            icon: Icon(Icons.more_horiz, color: Colors.white)));
  }

  void showMore(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(ScreenUtil.getScreenW(context) - 100, 100, 10, 0),
        items: [
          PopupMenuItem(
              child: Row(children: <Widget>[Icon(Icons.home), Text('首页')])),
          PopupMenuItem(
              child: Row(children: <Widget>[Icon(Icons.search), Text('搜索')]))
        ]);
  }
}
