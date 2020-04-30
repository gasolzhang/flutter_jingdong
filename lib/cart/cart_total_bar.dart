import 'package:circular_check_box/circular_check_box.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-30
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:provider/provider.dart';

import 'cart_state_provider.dart';

///
class CartTotalBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CartTotalBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[100], spreadRadius: 1, blurRadius: 1)
      ]),
      child: Consumer<CartStateProvider>(
        builder: (context, value, child) {
          return Row(
            children: <Widget>[
              CircularCheckBox(
                value: value.allSelected,
                activeColor: MyColors.primary,
                inactiveColor: Colors.grey[400],
                disabledColor: Colors.grey[400],
                onChanged: (value) {
                  Provider.of<CartStateProvider>(context, listen: false)
                      .changeAllSelected(value);
                },
              ),
              Text('全选',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14)),
              Expanded(child: Container()),
              value.editMode
                  ? Text('')
                  : RichText(
                      text: TextSpan(
                          text: '合计：',
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                          children: [
                            TextSpan(
                                text: '¥ 0',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 14))
                          ]),
                    ),
              value.editMode
                  ? Container(
                      margin: EdgeInsets.only(right: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        '删除',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.orange[900],
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        '结算',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
