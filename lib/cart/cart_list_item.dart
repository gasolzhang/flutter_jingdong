import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/cart/cart_goods_model.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'package:provider/provider.dart';
import 'cart_state_provider.dart';

/**
 *  Author:GasolZhang
 *  Date:2020-03-29
 */

///
class CartListItem extends StatefulWidget {
  final CartGoodsModel model;

  CartListItem({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _getCheckBox(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                _getShop(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getImage(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _getTitle(),
                        SizedBox(height: 10),
                        _getSpecs(),
                        SizedBox(height: 10),
                        Stack(
                          children: <Widget>[_getPrice()],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        Divider(
          height: 1,
          color: Colors.grey[400],
        ),
      ],
    );
  }

  Widget _getCheckBox() {
    return CircularCheckBox(
      value: widget.model?.checked ?? false,
      activeColor: MyColors.primary,
      inactiveColor: Colors.grey[400],
      disabledColor: Colors.grey[400],
      onChanged: (value) {
        if (value) {
          Provider.of<CartStateProvider>(context, listen: false)
              .addSelected(widget.model);
        } else {
          Provider.of<CartStateProvider>(context, listen: false)
              .removeSelected(widget.model);
        }
        setState(() {
          widget.model.checked = value;
        });
      },
    );
  }

  Widget _getShop() {
    return Row(
      children: <Widget>[
        Text(widget.model.shop,
            style: TextStyle(color: Colors.black45, fontSize: 14)),
        Icon(
          Icons.navigate_next,
          color: Colors.black45,
        ),
      ],
    );
  }

  Widget _getImage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.model.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      widget.model.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black45,
        fontSize: 14,
      ),
    );
  }

  Widget _getSpecs() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Text(
        widget.model.specs,
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  Widget _getPrice() {
    return Text(
      '¥ ${widget.model.price}',
      style: TextStyle(color: MyColors.primary, fontSize: 18),
    );
  }
}
