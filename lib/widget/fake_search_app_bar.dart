import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingdong/router.dart';

import '../res.dart';

/**
 *  Author:GasolZhang
 *  Date:2020-03-17
 */

///
typedef ScanCallback = Function(String result);

class FakeSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScanCallback scanCallback;

  FakeSearchAppBar({Key key, @required this.scanCallback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FakeSearchAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class FakeSearchAppBarState extends State<FakeSearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: SafeArea(
            top: true,
            child: Row(children: <Widget>[
              getScannerIcon(),
              getFakeInput(),
              getMessageIcon()
            ])));
  }

  Widget getScannerIcon() {
    return IconButton(
      onPressed: () async {
        try {
          String result = await BarcodeScanner.scan();
          widget.scanCallback(result);
        } on Exception catch (e) {
          widget.scanCallback('扫码失败');
        }
      },
      icon: ImageIcon(AssetImage(Res.icon_scan), size: 24, color: Colors.white),
    );
  }

  Widget getFakeInput() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ROUTER_SEARCH);
        },
        child: Container(
            padding: EdgeInsets.all(6),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
                Text('搜索关键字',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget getMessageIcon() {
    return IconButton(
        icon: ImageIcon(
          AssetImage(Res.icon_message),
          size: 24,
          color: Colors.white,
        ),
        onPressed: () {});
  }
}
