import 'dart:math';

import 'package:dio/dio.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constant.KEY_TOKEN);
    if (token != null && token.isNotEmpty) {
      options.headers[Constant.KEY_TOKEN] = token;
    }

    return super.onRequest(options);
  }
}

class CommonParamsInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    String curTime = (DateTime.now().millisecondsSinceEpoch / 1000).toString();
    String random = _getRandom();
    String versionCode = await _getVersionCode();
    options.queryParameters['Time'] = curTime;
    options.queryParameters['Random'] = random;
    options.queryParameters['Version'] = versionCode;
//    options.queryParameters['Sign'] = _getSign(options.queryParameters);
    return super.onRequest(options);
  }

  String _getRandom() {
    String alphabet =
        'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789';
    int len = 30;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < len; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  _getVersionCode() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.buildNumber;
  }

  String _getSign(Map<String, dynamic> params) {
    List<String> keys = params.keys.toList();
    keys.sort();
    String sign;
    for (int i = 0; i < keys.length; i++) {
      sign = '$sign${keys[i]}${params[keys[i]]}';
    }
    return md5.convert(utf8.encode(sign)).toString();
  }
}
