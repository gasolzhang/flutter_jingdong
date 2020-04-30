/**
 *  Author:GasolZhang
 *  Date:2020-03-16
 */
import 'package:flutter/cupertino.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:loading_animations/loading_animations.dart';

import '../res.dart';

///
class StateView extends StatelessWidget {
  final ShowState state;

  StateView({this.state});

  @override
  Widget build(BuildContext context) {
    if (state == ShowState.LOADING) {
      return Center(
          child: LoadingBumpingLine.circle(backgroundColor: MyColors.primary));
    }

    if (state == ShowState.EMPTY) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(Res.page_empty,
                  width: 100, color: MyColors.light_gray),
              SizedBox(height: 10),
              Text('数据为空', style: TextStyle(color: MyColors.light_gray))
            ]),
      );
    }

    if (state == ShowState.ERROR) {
      return Stack(children: <Widget>[
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(Res.network_error,
                    width: 100, color: MyColors.light_gray),
                SizedBox(height: 10),
                Text('网络异常', style: TextStyle(color: MyColors.light_gray))
              ]),
        ),
      ]);
    }

    return Text('');
  }
}
