import 'package:event_bus/event_bus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jingdong/cart/cart_state_provider.dart';
import 'package:jingdong/db/database.dart';
import 'package:jingdong/jpush.dart';
import 'package:jingdong/network/dio_util.dart';
import 'package:jingdong/router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'generated/i18n.dart';

EventBus eventBus = EventBus();

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider.value(value: CartStateProvider()),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    //statusBar设置为透明，去除半透明遮罩
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    doMyInit();

    return RefreshConfiguration(
      headerBuilder: () => ClassicHeader(
        idleText: '下拉刷新',
        releaseText: '释放刷新',
        refreshingText: '正在刷新',
        completeText: '刷新完毕',
        failedText: '刷新失败',
      ),
      footerBuilder: () => ClassicFooter(
        loadingText: '正在加载',
        noDataText: '没有更多了',
        failedText: '加载失败',
        canLoadingText: '释放加载',
        idleText: '上拉加载',
      ),
      enableScrollWhenRefreshCompleted: true,
      child: MaterialApp(
        title: '京东商城',
        theme: ThemeData(
            primaryColor: Colors.red,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent),
        routes: getRouter(),
        initialRoute: ROUTER_MAIN,
        //国际化配置
        localizationsDelegates: [
          S.delegate,
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('zh', 'CH'), // Hebrew
          // ... other locales the app supports
        ],
      ),
    );
  }

  void doMyInit() async {
    DioUtil.init();
    await DBHelper.init();
    await SpUtil.getInstance();
//    JPushUtil.init();
  }
}
