/**
 *  Author:GasolZhang
 *  Date:2020-03-29
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'package:provider/provider.dart';

import 'cart_state_provider.dart';

///
class CartAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool needBack;

  CartAppBar({Key key, this.needBack = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _State extends State<CartAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primary,
      child: SafeArea(
        top: true,
        child: Stack(
          children: <Widget>[_getBackButton(), _getTitle(), _getAction()],
        ),
      ),
    );
  }

  Widget _getBackButton() {
    if (widget.needBack) {
      return Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(10),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget _getTitle() {
    return Align(
      alignment: Alignment.center,
      child: Text('购物车',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _getAction() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Provider.of<CartStateProvider>(context, listen: false).changeMode();
          },
          child: Selector<CartStateProvider, bool>(
            builder: (context, value, child) {
              return Text(
                value ? '完成' : '编辑',
                style: TextStyle(color: Colors.white, fontSize: 16),
              );
            },
            selector: (context, provider) {
              return provider.editMode;
            },
            shouldRebuild: (pre, next) {
              return pre != next;
            },
          ),
        ),
      ),
    );
  }
}
