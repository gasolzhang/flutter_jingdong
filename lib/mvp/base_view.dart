import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/mvp/i_view.dart';
import 'package:jingdong/utils/log_utl.dart';

abstract class BaseState<S extends StatefulWidget, P extends BasePresenter>
    extends State<S> implements IView {
  P presenter;
  ShowState showState = ShowState.LOADING;
  int fetchCount = 0;
  int fetchThrehold = 0;
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    presenter = newPresenter();
    presenter?.attachView(this);
  }

  @override
  void dispose() {
    super.dispose();
    presenter?.dispose();
  }

  P newPresenter();

  @override
  void showLoading() {
    setState(() {
      showState = ShowState.LOADING;
    });
  }

  @override
  void showEmpty() {
    setState(() {
      showState = ShowState.EMPTY;
      LogUtil.d('显示空页面');
    });
  }

  @override
  void showError() {
    setState(() {
      showState = ShowState.ERROR;
    });
  }

  @override
  void tryShowNormal() {
    if (fetchCount >= fetchThrehold) {
      setState(() {
        showState = ShowState.NORMAL;
      });
    }
  }
}
