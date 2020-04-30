class Constant {
  static const String KEY_TOKEN = 'Token';
  static const bool isRelease = bool.fromEnvironment('dart.vm.product');
}

class UrlPath {
  static const String _GROUP_HOME = '/home';
  static const String HOME_BANNER = _GROUP_HOME + '/banner';
  static const String HOME_GUESS = _GROUP_HOME + '/guess';
  static const String HOME_LIST = _GROUP_HOME + '/hot_goods';

  static const String _GROUP_CATEGORY = '/category';
  static const String CATEGORY_FIRST = _GROUP_CATEGORY + '/first';
  static const String CATEGORY_SECCOND = _GROUP_CATEGORY + '/seccond';

  static const String _GROUP_PRODUCT = '/product';
  static const String PRODUCT_CATE_LIST = _GROUP_PRODUCT + '/cate_list';
  static const String PRODUCT_DETAIL_BANNER = _GROUP_PRODUCT + '/detail_banner';
  static const String PRODUCT_DETAIL_INFO = _GROUP_PRODUCT + '/detail_info';
  static const String PRODUCT_SPEC_HEADER_INFO =
      _GROUP_PRODUCT + '/spec_header_info';
  static const String PRODUCT_SPEC = _GROUP_PRODUCT + '/spec';

  static const String _GROUP_USER = '/user';
  static const String USER_LOGIN = _GROUP_USER + '/login';
  static const String USER_REGIST = _GROUP_USER + '/regist';
}

enum ShowState { LOADING, EMPTY, ERROR, NORMAL }
