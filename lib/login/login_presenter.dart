import 'package:jingdong/constant/constant.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-31
 */

import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/network/dio_util.dart';
import 'package:jingdong/user/user_model.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'login_page.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';

///
class LoginPresenter extends BasePresenter<LoginState> {
  void doLogin({String phone, String password}) {
    //sha1加密处理
    var bytes = utf8.encode(password);
    var digest = sha1.convert(bytes);
    String cryptoPassword = hex.encode(digest.bytes);
    LogUtil.d("加密后的密码：$cryptoPassword");

    DioUtil.doRequest<UserModel>(Method.POST, UrlPath.USER_LOGIN,
        params: {"Phone": phone, "Password": cryptoPassword},
        onSuccess: (model) => v.onLoginSuccess(model),
        cancelToken: cancelToken);
  }
}

class RegistModel {}
