/**
 *  Author:GasolZhang
 *  Date:2020-03-26
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///

class JDButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final GestureTapCallback onTap;
  final double width;
  final double height;

  JDButton(
      {Key key, this.text, this.bgColor, this.onTap, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 100,
        height: height ?? 38,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(child: Text(text, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
      ),
    );
  }
}
