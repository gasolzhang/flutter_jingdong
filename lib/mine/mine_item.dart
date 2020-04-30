/**
 *  Author:GasolZhang
 *  Date:2020-03-30
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///

class MineItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final TapAction onTap;

  MineItem({Key key, this.icon, this.title, this.onTap}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black45, fontSize: 16),
              ),
              Expanded(
                child: Text(''),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey[400],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey[400],
        )
      ],
    );
  }
}

typedef TapAction = void Function();
