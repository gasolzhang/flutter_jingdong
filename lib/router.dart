import 'package:flutter/cupertino.dart';
import 'package:jingdong/forget_password/forget_page.dart';
import 'package:jingdong/goods_detail/goods_detail_page.dart';
import 'package:jingdong/login/login_page.dart';
import 'package:jingdong/main/main_page.dart';
import 'package:jingdong/prouct_list/product_list_page.dart';
import 'package:jingdong/regist/regist_page.dart';
import 'package:jingdong/search/search_page.dart';
import 'package:jingdong/widget/gallery_page.dart';

Map<String, WidgetBuilder> getRouter() {
  Map<String, WidgetBuilder> map = {
    ROUTER_MAIN: (context) => MainPage(),
    ROUTER_PRODUCT_LIST: (context) => ProductListPage(),
    ROUTER_SEARCH: (context) => SearchPage(),
    ROUTER_GOODS_DETAIL: (context) => GoodsDetailPage(),
    ROUTER_GALLERY: (context) => GalleryPage(),
    ROUTER_LOGIN: (context) => LoginPage(),
    ROUTER_REGIST: (context) => RegistPage(),
    ROUTER_NEW_PASSWORD: (context) => ForgetPage(),
  };
  return map;
}

const ROUTER_MAIN = '/main';
const ROUTER_PRODUCT_LIST = '/product_list';
const ROUTER_SEARCH = '/goods_search';
const ROUTER_GOODS_DETAIL = '/goods_detail';
const ROUTER_GALLERY = '/gallery';
const ROUTER_LOGIN = '/login';
const ROUTER_REGIST = '/regist';
const ROUTER_NEW_PASSWORD = '/new_password';
