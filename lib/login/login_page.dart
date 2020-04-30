import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/router.dart';
import 'package:jingdong/user/user_event.dart';
import 'package:jingdong/login/login_presenter.dart';
import 'package:jingdong/main.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/user/user_manager.dart';
import 'package:jingdong/user/user_model.dart';
import 'package:jingdong/widget/back_app_bar.dart';

import '../res.dart';

/**
 *  Author:GasolZhang
 *  Date:2020-03-31
 */

///
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends BaseState<LoginPage, LoginPresenter> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: '用户登录'),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              _getImage(),
              SizedBox(
                height: 50,
              ),
              _getPhoneInput(),
              SizedBox(
                height: 10,
              ),
              _getPasswordInput(),
              SizedBox(
                height: 10,
              ),
              Stack(children: <Widget>[_getForgetText(), _getRegistText()]),
              SizedBox(
                height: 50,
              ),
              _getLoginButton(),
            ],
          ),
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _getImage() {
    return Image.asset(
      Res.logo,
      width: 100,
      height: 100,
    );
  }

  Widget _getPhoneInput() {
    return TextField(
      controller: _phoneController,
      autofocus: true,
      maxLines: 1,
      maxLength: 11,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: 16),
      onChanged: (value) {
        setState(() {
          //仅仅用来通知刷新
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300])),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300])),
          hintText: '手机号码',
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
          counterText: ''),
    );
  }

  Widget _getPasswordInput() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      autofocus: true,
      maxLines: 1,
      maxLength: 20,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: 16),
      onChanged: (value) {
        setState(() {
          //仅仅用来通知刷新
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300])),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300])),
          hintText: '密码',
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
          counterText: ''),
    );
  }

  Widget _getForgetText() {
    return Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, ROUTER_NEW_PASSWORD),
          child: Text('忘记密码',
              style: TextStyle(color: Colors.black45, fontSize: 14)),
        ));
  }

  Widget _getRegistText() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ROUTER_REGIST),
        child: Text(
          '新用户注册',
          style: TextStyle(color: Colors.black45, fontSize: 14),
        ),
      ),
    );
  }

  Widget _getLoginButton() {
    return MaterialButton(
        minWidth: double.infinity,
        height: 45,
        onPressed: (_phoneController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty)
            ? () {
                presenter.doLogin(
                    phone: _phoneController.text,
                    password: _passwordController.text);
              }
            : null,
        color: MyColors.primary,
        disabledColor: Colors.grey,
        child: Text('登录',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)));
  }

  @override
  LoginPresenter newPresenter() {
    return LoginPresenter();
  }

  void onLoginSuccess(UserModel model) {
    UserManager.login(model);
    Navigator.pop(context);
  }
}
