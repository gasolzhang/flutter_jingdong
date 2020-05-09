import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/cart/cart_page.dart';
import 'package:jingdong/category/category.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/home/home_page.dart';
import 'package:jingdong/user/user_event.dart';
import 'package:jingdong/main.dart';
import 'package:jingdong/mine/mine_page.dart';
import 'package:jingdong/router.dart';
import 'package:jingdong/user/user_manager.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainPage> {
  int _curIndex = 0;
  PageController _pageController;
  StreamSubscription loginOrOutSub;
  DateTime _lastPressedAt; //上次点击时间

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _curIndex);
    loginOrOutSub = eventBus.on<LoginOrOutEvent>().listen((event) {
      setState(() {
        this._curIndex = 0;
        _pageController.jumpToPage(_curIndex);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginOrOutSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ///WillPopScope拦截Back键导致的pop事件，实现再按一次退出
    return WillPopScope(
      onWillPop: () async{
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          Fluttertoast.showToast(msg: '再按一次退出应用');
          return false;
        }
        return true;
      },
      child: Scaffold(
          body: getBody(), bottomNavigationBar: getBottomNavigationBar()),
    );
  }

  Widget getBody() {
    return PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {},
        children: <Widget>[HomePage(), CategoryPage(), CartPage(), MinePage()]);
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: MyColors.primary,
      unselectedItemColor: MyColors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: this._curIndex,
      onTap: (index) {
        if ((index == 2 || index == 3) && !UserManager.isLogin()) {
          Navigator.of(context).pushNamed(ROUTER_LOGIN);
          return;
        }
        setState(() {
          this._curIndex = index;
          _pageController.jumpToPage(_curIndex);
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
        BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('分类')),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text('购物车')),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
      ],
    );
  }
}
