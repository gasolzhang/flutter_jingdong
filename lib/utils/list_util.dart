class ListUtil {
  static bool isEmpty(List list) {
    return list == null || list.length == 0;
  }

  static bool isNotEmpty(List list) {
    return !isEmpty(list);
  }
}
