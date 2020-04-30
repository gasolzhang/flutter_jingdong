/**
 *  Author:GasolZhang
 *  Date:2020-03-15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';

///
typedef ItemSelectCallback = Function(int index);

class ProductFilterBar extends StatefulWidget {
  final ItemSelectCallback selectCallback;

  ProductFilterBar({
    Key key,
    @required this.selectCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterBarState();
  }
}

class FilterBarState extends State<ProductFilterBar> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Colors.white,
        child: Row(children: <Widget>[
          FilterItem(
            index: 0,
            name: '综合',
            needArrow: false,
            selected: selectIndex == 0,
            onTap: (index) {
              setState(() {
                selectIndex = index;
                widget.selectCallback(index);
              });
            },
          ),
          FilterItem(
            index: 1,
            name: '销量',
            needArrow: true,
            selected: selectIndex == 1 || selectIndex == 2,
            arrowDown: selectIndex == 1,
            onTap: (index) {
              setState(() {
                selectIndex = index;
                widget.selectCallback(index);
              });
            },
          ),
          FilterItem(
            index: 3,
            name: '价格',
            needArrow: true,
            selected: selectIndex == 3 || selectIndex == 4,
            arrowDown: selectIndex == 3,
            onTap: (index) {
              setState(() {
                selectIndex = index;
                widget.selectCallback(index);
              });
            },
          ),
          FilterItem(
            index: 5,
            name: '筛选',
            needArrow: false,
            selected: false,
            onTap: (index) {
              setState(() {
                selectIndex = index;
                widget.selectCallback(index);
              });
            },
          )
        ]));
  }
}

class FilterItem extends StatelessWidget {
  final int index;
  final String name;
  final bool needArrow;
  final bool selected;
  final bool arrowDown;
  final ItemSelectCallback onTap;

  FilterItem(
      {this.index,
      this.name,
      this.needArrow = false,
      this.selected = false,
      this.arrowDown = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        if (needArrow) {
          int actulIndex = arrowDown ? index+1 : index;
          onTap(actulIndex);
        } else {
          onTap(index);
        }
      },
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(name,
                style: TextStyle(
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? MyColors.primary : MyColors.black)),
            needArrow
                ? Icon(
                    arrowDown ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    color: selected ? MyColors.primary : MyColors.black,
                    size: 14,
                  )
                : Text('')
          ],
        ),
      ),
    ));
  }
}
