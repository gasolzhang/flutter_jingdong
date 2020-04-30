import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
class GoodsDetailWebPage extends StatefulWidget {
  final String goodsId;

  GoodsDetailWebPage({Key key, this.goodsId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<GoodsDetailWebPage> with AutomaticKeepAliveClientMixin<GoodsDetailWebPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(initialUrl: 'https://www.baidu.com',));
  }

  @override
  bool get wantKeepAlive => true;

}
