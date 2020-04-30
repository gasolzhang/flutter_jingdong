/**
 *  Author:GasolZhang
 *  Date:2020-04-01
 */

import 'package:jingdong/mvp/base_presenter.dart';

import 'forget_page.dart';

///
class ForgetPresenter extends BasePresenter<ForgetState> {
  void newPassword({String phone, String code, String password}) {
    v.onNewPasswordSuccess();
  }
}
