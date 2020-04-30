/**
 *  Author:GasolZhang
 *  Date:2020-03-17
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/utils/log_utl.dart';

///
typedef SearchCallback = Function(String content);

class TrueSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchCallback searchCallback;
  final String keyWord;
  final String hint;
  final bool autoFocus;

  TrueSearchAppBar(
      {Key key,
      this.searchCallback,
      this.keyWord,
      this.hint,
      this.autoFocus: true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TrueSearchAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class TrueSearchAppBarState extends State<TrueSearchAppBar> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.keyWord;
    return Container(
      color: MyColors.primary,
      child: SafeArea(
        top: true,
        child:
            Row(children: <Widget>[getBackIcon(), getInput(), getSearchText()]),
      ),
    );
  }

  Widget getBackIcon() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
    );
  }

  Widget getInput() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(children: <Widget>[
          Icon(Icons.search, color: Colors.grey[400]),
          Expanded(
              child: TextField(
            autofocus: widget.autoFocus,
            controller: _controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            style: TextStyle(color: Colors.black, fontSize: 16),
            maxLines: 1,
            onSubmitted: (string) {
              //直接掉调接口
              LogUtil.d('搜索关键字：$string');
              widget.searchCallback(string);
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 14),
                hintText: widget.hint ?? '请输入搜索关键字',
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none),
          )),
        ]),
      ),
    );
  }

  Widget getSearchText() {
    //强制收起软键盘
//    FocusScope.of(context).requestFocus(FocusNode());
    return InkWell(
        onTap: () {
          LogUtil.d('搜索关键字：${_controller.text}');
          widget.searchCallback(_controller.text);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Text('搜索', style: TextStyle(color: Colors.white, fontSize: 16)),
        ));
  }
}
