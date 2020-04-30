import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/goods_detail/goods_spec_bottom_sheet.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/router.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'goods_child_info_model.dart';
import 'goods_child_presenter.dart';

/**
 *  Author:GasolZhang
 *  Date:2020-03-24
 */

///
class GoodsChildPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoodsChildState();
  }
}

class GoodsChildState extends BaseState<GoodsChildPage, GoodsChildPresenter> with AutomaticKeepAliveClientMixin<GoodsChildPage>{
  List<String> _banner;
  GoodsChildInfoModel _infoModel;
  String _selectSpec;
  String _postFare;

  @override
  void initState() {
    super.initState();
    fetchThrehold = 2;
    presenter.fetchBanner();
    presenter.fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.d('构建：GoodsChildState');
    return Scaffold(
        body: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return _getBanner();
              }
              if (index == 1) {
                return _getInfo();
              }
              if (index == 2) {
                return _getSpec();
              }
              if (index == 3) {
                return _getPostFare();
              }
              return Container();
            },
            itemCount: 4));
  }

  Widget _getBanner() {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
            onTap: (index) {
              Navigator.pushNamed(context, ROUTER_GALLERY,
                  arguments: {'images': _banner, 'initalIndex': index});
            },
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    size: 5, activeSize: 5, space: 3)),
            itemCount: _banner?.length ?? 0,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                  imageUrl: _banner[index], fit: BoxFit.cover);
            }));
  }

  Widget _getInfo() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(_infoModel?.title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
                fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(_infoModel?.info,
            style: TextStyle(color: Colors.red, fontSize: 16)),
      ),
      Stack(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
                text: TextSpan(
                    text: '现价：',
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                    children: [
                  TextSpan(
                      text: '¥${_infoModel?.price}',
                      style: TextStyle(fontSize: 20, color: MyColors.primary))
                ])),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              text: TextSpan(
                  text: '原价：',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  children: [
                    TextSpan(
                        text: '¥${_infoModel?.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough))
                  ]),
            ),
          ),
        )
      ])
    ]);
  }

  Widget _getSpec() {
    return InkWell(
      onTap: () {
        _showSpecSheet();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(children: <Widget>[
              Expanded(
                  child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: '已选：',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: _selectSpec,
                          style: TextStyle(color: Colors.black45, fontSize: 14))
                    ]),
              )),
              Icon(
                Icons.more_horiz,
                size: 20,
                color: Colors.grey[400],
              )
            ]),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 1,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  void _showSpecSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return GoodsSpecBottomSheet();
        });
  }

  Widget _getPostFare() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(children: <Widget>[
            RichText(
              text: TextSpan(
                  text: '运费：',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: _postFare,
                        style: TextStyle(color: Colors.black45, fontSize: 14))
                  ]),
            )
          ]),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          height: 1,
          color: Colors.grey[400],
        )
      ],
    );
  }

  @override
  GoodsChildPresenter newPresenter() {
    return GoodsChildPresenter();
  }

  void onFetchBanner(List<String> banner) {
    _banner = banner;
    fetchCount++;
    tryShowNormal();
  }

  void onFetchInfo(GoodsChildInfoModel model) {
    _infoModel = model;
    fetchCount++;
    tryShowNormal();
  }

  void onFetchError() {
    showError();
  }

  @override
  bool get wantKeepAlive => true;
}
