import 'package:count_down_timer/count_down_timer.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-04-01
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/forget_password/forget_presenter.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/widget/back_app_bar.dart';

import '../res.dart';

///
class ForgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgetState();
  }
}

class ForgetState extends BaseState<ForgetPage, ForgetPresenter> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        title: '忘记密码',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              _getImage(),
              SizedBox(height: 50),
              _getPhoneInput(context),
              SizedBox(height: 10),
              Stack(
                children: <Widget>[
                  _getVerifyCodeInput(),
                  _getCountDownButton()
                ],
              ),
              SizedBox(height: 10),
              _getPasswordInput(),
              SizedBox(
                height: 50,
              ),
              _getLoginButton(),
            ],
          ),
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

  Widget _getPhoneInput(BuildContext context) {
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

  Widget _getVerifyCodeInput() {
    return TextField(
      controller: _codeController,
      autofocus: true,
      maxLength: 6,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 10),
        hintText: '验证码',
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
        counterText: '',
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300])),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300])),
      ),
      onChanged: (value) {
        //仅仅用来通知刷新
      },
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
          hintText: '新密码',
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
          counterText: ''),
    );
  }

  Widget _getCountDownButton() {
    return Positioned(
      right: 10,
      top: 10,
      child: Container(
        width: 90,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.primary),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: CountDownWidget(
            onTapCallback: (timer) {
              print('onTapCallback：current is ${timer.tick}s');
            },
            language: CountDown.ZH,
            enableTS: TextStyle(color: MyColors.primary),
            disableTS: TextStyle(color: MyColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _getLoginButton() {
    return MaterialButton(
        minWidth: double.infinity,
        height: 45,
        onPressed: (_phoneController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty &&
                _codeController.text.isNotEmpty)
            ? () {
                presenter.newPassword(
                    phone: _phoneController.text,
                    code: _codeController.text,
                    password: _passwordController.text);
              }
            : null,
        color: MyColors.primary,
        disabledColor: Colors.grey,
        child: Text('修改密码',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)));
  }

  void onNewPasswordSuccess() {
    Fluttertoast.showToast(msg: '密码修改成功，请重新登录');
    Navigator.pop(context);
  }

  void onNewPasswordError() {}

  @override
  ForgetPresenter newPresenter() {
    return ForgetPresenter();
  }
}
