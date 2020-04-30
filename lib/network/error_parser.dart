import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/user/user_manager.dart';
import 'package:jingdong/utils/log_utl.dart';

import 'http_const.dart';

class ErrorHandler {
  static bool hasError(Response response) {
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      int errCode = response.data[HttpConst.CODE];
      if (errCode == 600) {
        return false;
      } else {
        //TODO 其他需要特殊处理的错误需要在此处理
        if (errCode == 603) {
          //token失效，需要退出登录
          UserManager.logout();
        }

        String errMsg = response.data[HttpConst.MESSAGE];
        Fluttertoast.showToast(msg: "errCode=$errCode 错误信息：$errMsg");
        LogUtil.d("请求发生错误：errCode=$errCode 错误信息：$errMsg");
      }
    }
    return true;
  }
}
