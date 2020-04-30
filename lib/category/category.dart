import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/utils/list_util.dart';
import 'package:jingdong/widget/back_app_bar.dart';
import 'package:jingdong/widget/state_view.dart';

import '../router.dart';
import 'category_model.dart' as CM;
import 'category_presenter.dart';
import 'category_seccond_model.dart' as CSM;

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends BaseState<CategoryPage, CategoryPresenter>
    with AutomaticKeepAliveClientMixin {
  List<CM.DatasListBean> _categories;
  List<CSM.DatasListBean> _seccondList;
  int _curCateIndex = 0;

  @override
  void initState() {
    super.initState();
    presenter.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(appBar: BackAppBar(), body: getBody());
  }

  Widget getBody() {
    return Row(
      children: <Widget>[getCateList(), getCateGrid()],
    );
  }

  Widget getCateList() {
    return Container(
      width: 100,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: _categories?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _curCateIndex = index;
                presenter.fetchSeccondCate(_categories[index].id);
              });
            },
            child: Container(
                color:
                    _curCateIndex == index ? MyColors.white : Colors.grey[100],
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(_categories[index].name,
                          style: TextStyle(
                              fontSize: 14,
                              color: _curCateIndex == index
                                  ? MyColors.black
                                  : MyColors.grey,
                              fontWeight: _curCateIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                    ),
                    Divider(height: 1)
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget getCateGrid() {
    return Expanded(
      child: showState == ShowState.NORMAL
          ? GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.3),
              itemBuilder: (context, index) {
                return getGridItem(index);
              },
              itemCount: _seccondList?.length ?? 0)
          : StateView(state: showState),
    );
  }

  Widget getGridItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ROUTER_PRODUCT_LIST,
            arguments: {'cate_id': _seccondList[index].id});
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.light_gray, width: 1)),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1 / 1,
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: _seccondList[index].image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(_seccondList[index].name, style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }

  @override
  CategoryPresenter newPresenter() {
    return CategoryPresenter();
  }

  void onFetchCategories(List<CM.DatasListBean> datas) {
    if (ListUtil.isNotEmpty(datas)) {
      _categories = datas;
      tryShowNormal();
      presenter.fetchSeccondCate(datas[0].id);
    }
  }

  void onFetchSeccondCate(List<CSM.DatasListBean> datas) {
    if (ListUtil.isEmpty(datas)) {
      showEmpty();
      return;
    }
    _seccondList = datas;
    tryShowNormal();
  }

  @override
  bool get wantKeepAlive => true;
}
