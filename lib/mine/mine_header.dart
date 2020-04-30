import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/user/user_event.dart';
import 'package:jingdong/main.dart';
import 'package:jingdong/res.dart';
import 'package:jingdong/user/user_manager.dart';
import 'package:jingdong/user/user_model.dart';

/**
 *  Author:GasolZhang
 *  Date:2020-03-30
 */

///
class MineHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MineHeader> {
  UserModel _userModel;
  StreamSubscription _updateSub;
  StreamSubscription _loginOutSub;

  @override
  void initState() {
    super.initState();
    _userModel = UserManager.getUserInfo();
    _updateSub = eventBus.on<UserInfoChangeEvent>().listen((event) {
      setState(() {
        _userModel = UserManager.getUserInfo();
      });
    });
    _loginOutSub = eventBus.on<LoginOrOutEvent>().listen((event) {
      setState(() {
        _userModel = UserManager.getUserInfo();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _updateSub.cancel();
    _loginOutSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Res.mine_header), fit: BoxFit.cover)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: _userModel?.Avatar == ''
                  ? AssetImage(Res.place_avatar)
                  : CachedNetworkImageProvider(_userModel?.Avatar ?? ''),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _userModel?.Name ?? '',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                _userModel?.Sign ?? '',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
