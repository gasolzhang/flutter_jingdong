import 'package:jingdong/constant/constant.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-04-01
 */

import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/network/dio_util.dart';
import 'package:jingdong/regist/regist_page.dart';
import 'package:jingdong/user/user_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';

///
class RegistPresenter extends BasePresenter<RegistState> {
  void doRegist({String phone, String code, String password}) {
    //sha1加密处理
    var bytes = utf8.encode(password);
    var digest = sha1.convert(bytes);
    String cryptoPassword = hex.encode(digest.bytes);

    DioUtil.doRequest<UserModel>(Method.POST, UrlPath.USER_REGIST,
        params: {"Phone": phone, "Password": cryptoPassword, "Code": code},
        onSuccess: (model) => v.onRegistSuccess(model),
        cancelToken: cancelToken);
  }
}
