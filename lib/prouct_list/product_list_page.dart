import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/colors/colors.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/mvp/product_list_model.dart';
import 'package:jingdong/prouct_list/product_filter_bar.dart';
import 'package:jingdong/prouct_list/product_list_presenter.dart';
import 'package:jingdong/router.dart';
import 'package:jingdong/utils/list_util.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'package:jingdong/widget/state_view.dart';
import 'package:jingdong/widget/true_search_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListState();
  }
}

class ProductListState
    extends BaseState<ProductListPage, ProductListPresenter> {
  String cateId;
  String keyWord;
  bool hasGetPrefix = false;
  List<DatasListBean> _productDatas = [];
  int _pageIndex;
  int _orderIndex = 0;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    if (!hasGetPrefix) {
      Map<String, String> argument = ModalRoute.of(context).settings.arguments;
      keyWord = argument['key_word'];
      cateId = argument['cate_id'];
      LogUtil.d('keyWord=$keyWord cateId=$cateId');
      presenter.fetchProducts(cateId: cateId, keyWord: keyWord);
      hasGetPrefix = !hasGetPrefix;
    }

    return Scaffold(
      key: key,
      appBar: TrueSearchAppBar(
          keyWord: keyWord,
          autoFocus: false,
          searchCallback: (content) {
            keyWord = content;
            presenter.fetchProducts(
                cateId: cateId, keyWord: content, order: _orderIndex);
          }),
      body: Container(width: double.infinity, child: getBody()),
      endDrawer: Drawer(
        child: Container(child: Text('筛选菜单')),
      ),
    );
  }

  Widget getBody() {
    return Column(children: <Widget>[getFilterBar(), getList()]);
  }

  Widget getFilterBar() {
    return ProductFilterBar(selectCallback: (index) {
      if (index == 5) {
        key.currentState.openEndDrawer();
      } else {
        _orderIndex = index;
        presenter.fetchProducts(cateId: cateId, keyWord: keyWord, order: index);
      }
    });
  }

  Widget getList() {
    return Expanded(
      child: SmartRefresher(
          controller: _controller,
          enablePullDown: false,
          enablePullUp: showState == ShowState.NORMAL,
          onLoading: () {
            presenter.loadMoreProducts(
                cateId: cateId,
                keyWord: keyWord,
                pageIndex: _pageIndex + 1,
                order: _orderIndex);
          },
          child: showState == ShowState.NORMAL
              ? ListView.builder(
                  itemCount: _productDatas?.length ?? 0,
                  itemBuilder: (context, index) {
                    return getListItem(index);
                  })
              : StateView(state: showState)),
    );
  }

  Widget getListItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ROUTER_GOODS_DETAIL);
      },
      child: Container(
        width: double.infinity,
        height: 141,
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      'http://d.hiphotos.baidu.com/zhidao/pic/item/6f061d950a7b020850edff8860d9f2d3572cc8b7.jpg',
                      width: 140,
                      height: 140,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_productDatas[index].title,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            getProductTags(_productDatas[index].tags),
                            Text(_productDatas[index].price,
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 14))
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            Divider(height: 1, color: MyColors.light_gray)
          ],
        ),
      ),
    );
  }

  Widget getProductTags(List<String> tags) {
    List<Widget> list = [];
    for (int i = 0; i < tags.length; i++) {
      Container container = Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(tags[i]));
      list.add(container);
      list.add(SizedBox(width: 10));
    }
    return Wrap(direction: Axis.horizontal, children: list);
  }

  @override
  ProductListPresenter newPresenter() {
    return ProductListPresenter();
  }

  void onFetchProductDatas(ProductListModel model) {
    _pageIndex = model.pageIndex;
    _productDatas = model.datas;

    if (ListUtil.isEmpty(_productDatas)) {
      showEmpty();
      return;
    }
    tryShowNormal();
  }

  void onFetchError() {
    if (ListUtil.isEmpty(_productDatas)) {
      showError();
    }
  }

  void onLoadMoreProductDatas(ProductListModel model) {
    if (ListUtil.isEmpty(model.datas)) {
      _controller.loadNoData();
      return;
    }

    _productDatas.addAll(model.datas);
    _pageIndex = model.pageIndex;
    _controller.loadComplete();
    tryShowNormal();
  }

  void onLoadMoreError() {
    _controller.loadFailed();
  }
}
