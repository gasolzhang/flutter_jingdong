/**
 *  Author:GasolZhang
 *  Date:2020-03-31
 */

import 'package:flustars/flustars.dart';
import 'package:jingdong/main.dart';
import 'package:jingdong/user/user_event.dart';
import 'package:jingdong/user/user_model.dart';

///
class UserManager {
  static bool isLogin() {
    UserModel info = getUserInfo();
    return info != null;
  }

  static UserModel getUserInfo() {
    var info = SpUtil.getObject('user_info');
    if (info != null) {
      return UserModel.fromJson(info);
    }
    return null;
  }

  static putUserInfo(UserModel model) async {
    await SpUtil.putObject('user_info', model?.toJson());
  }

  static removeUserInfo() async {
    await SpUtil.remove('user_info');
  }

  static String getToken() {
    UserModel info = getUserInfo();
    if (info == null) {
      return null;
    }
    return info.Token;
  }

  static login(UserModel model) async{
    await putUserInfo(model);
    eventBus.fire(LoginOrOutEvent(true));
  }

  static logout() async{
    if(isLogin()){
      await removeUserInfo();
      eventBus.fire(LoginOrOutEvent(false));
    }
  }
}



