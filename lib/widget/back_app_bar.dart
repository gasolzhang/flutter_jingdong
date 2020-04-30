/**
 *  Author:GasolZhang
 *  Date:2020-03-16
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';

class BackAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  BackAppBar({Key key, this.title = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BackAppState();
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class BackAppState extends State<BackAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primary,
      child: SafeArea(
        top: true,
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}
