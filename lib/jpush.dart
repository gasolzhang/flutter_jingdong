///**
// *  Author:GasolZhang
// *  Date:2020-04-03
// */
//
//import 'package:flutter_jpush/flutter_jpush.dart';
//
/////
//class JPushUtil {
//  static void init() async {
//    print("初始化jpush");
//    await FlutterJPush.startup();
//    print("初始化jpush成功");
//
//    FlutterJPush.addConnectionChangeListener((bool connected) {
//      if (connected) {
//        FlutterJPush.getRegistrationID().then((String regId) {
//          print("主动获取设备号:$regId");
//        });
//      }
//    });
//
//    FlutterJPush.addnetworkDidLoginListener((String registrationId) {
//      /// 用于推送
//      print("收到设备号:$registrationId");
//    });
//
//    FlutterJPush.addReceiveNotificationListener(
//        (JPushNotification notification) {
//      /// 收到推送
//      print(
//          "收到推送提醒: title:${notification.title} content:${notification.content}");
//    });
//
//    FlutterJPush.addReceiveOpenNotificationListener(
//        (JPushNotification notification) {
//      print("打开了推送提醒: $notification");
//    });
//
//    FlutterJPush.addReceiveCustomMsgListener((JPushMessage msg) {
//      print("收到推送消息提醒: $msg");
//    });
//  }
//}
