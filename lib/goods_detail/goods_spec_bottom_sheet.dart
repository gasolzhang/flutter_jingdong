import 'package:cached_network_image/cached_network_image.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-26
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/goods_detail/goods_spec_name_model.dart';
import 'package:jingdong/mvp/base_presenter.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/network/dio_util.dart';
import 'package:jingdong/widget/jd_button.dart';

import 'goods_spec_content_model.dart';
import 'goods_spec_header_model.dart';

///
class GoodsSpecBottomSheet extends StatefulWidget {
  final String goodsId;
  final List<GoodsSpecNameModel> specs;

  GoodsSpecBottomSheet({Key key, this.goodsId, this.specs}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends BaseState<GoodsSpecBottomSheet, _Presenter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[_getHeaderPart(), _getList(), _getButtons()],
      ),
    );
  }

  Widget _getList() {
    return Expanded(
        child: ListView.builder(
            itemCount: widget.specs?.length ?? 0,
            itemBuilder: (context, index) {
              return Text('item$index');
            }));
  }

  Widget _getSpec(GoodsSpecNameModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            model.name,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }

  Widget _getHeaderPart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl:
                  'https://images.liqucn.com/img/h1/h994/img201802021024070_info300X300.jpg'),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.only(left: 10),
          height: 100,
          child: Column(
//            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '¥ 79.00',
                style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '编号：20200327',
                style: TextStyle(color: Colors.grey[400], fontSize: 10),
              )
            ],
          ),
        )),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.cancel,
            color: Colors.grey[400],
            size: 20,
          ),
        )
      ],
    );
  }

  Widget _getButtons() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          JDButton(
            text: '加入购物车',
            width: 150,
            bgColor: Colors.orange,
            onTap: () {
              Fluttertoast.showToast(msg: '加入购物车');
            },
          ),
          SizedBox(width: 20),
          JDButton(
            width: 150,
            text: '立即购买',
            bgColor: MyColors.primary,
            onTap: () {
              Fluttertoast.showToast(msg: '立即购买');
            },
          )
        ],
      ),
    );
  }

  @override
  _Presenter newPresenter() {
    return _Presenter();
  }

  void onFetchHeaderInfo(GoodsSpecHeaderModel model) {
    fetchCount++;
    tryShowNormal();
  }

}

class _Presenter extends BasePresenter<_State> {
  void fetchHeaderInfo() {
//    DioUtil.doRequest<GoodsSpecHeaderModel>(
//        Method.GET, UrlPath.PRODUCT_SPEC_HEADER_INFO,
//        cancelToken: cancelToken, onSuccess: (model) {}, onError: () {});

    GoodsSpecHeaderModel model = GoodsSpecHeaderModel(
        image: 'https://www.diyimei.net/upload/2018/1523807721171765.jpg',
        price: '180.00',
        number: '20200327',
        count: 100);
    v.onFetchHeaderInfo(model);
  }

  void fetchSpec(String specName){
//    DioUtil.doRequest<GoodsSpecHeaderModel>(
//        Method.GET, UrlPath.PRODUCT_SPEC,
//        cancelToken: cancelToken, onSuccess: (model) {}, onError: () {});
  GoodsSpecContentModel model = GoodsSpecContentModel();
  model.specs = ["黑色","白色","蓝色"];


  }
}
