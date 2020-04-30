import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/mine/mine_item.dart';
import 'package:jingdong/mine/mine_presenter.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/user/user_manager.dart';

import '../res.dart';
import 'mine_header.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MineState();
  }
}

class MineState extends BaseState<MinePage, MinePresenter>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MineHeader(),
          MineItem(
            icon: Icon(
              Icons.library_books,
              color: MyColors.primary,
            ),
            title: '全部订单',
            onTap: () {
              Fluttertoast.showToast(msg: '打开订单页面');
            },
          ),
          MineItem(
            icon: Icon(
              Icons.payment,
              color: Colors.green,
            ),
            title: '待付款',
            onTap: () {
              Fluttertoast.showToast(msg: '打开待支付页面');
            },
          ),
          MineItem(
            icon: Icon(
              Icons.directions_car,
              color: Colors.orange,
            ),
            title: '待收货',
            onTap: () {
              Fluttertoast.showToast(msg: '打开待收货页面');
            },
          ),
          Container(
            color: Colors.grey[200],
            height: 10,
          ),
          MineItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: '我的收藏',
            onTap: () {
              Fluttertoast.showToast(msg: '打开收藏页面');
            },
          ),
          MineItem(
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: '在线客服',
            onTap: () {
              Fluttertoast.showToast(msg: '打开客服页面');
            },
          ),
          SizedBox(height: 50),
          _getLogoutButton(),
        ],
      ),
    ));
  }

  Widget _getLogoutButton() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 45,
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () {
          UserManager.logout();
        },
        color: MyColors.primary,
        child: Text(
          '退出登录',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  MinePresenter newPresenter() {
    return MinePresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
