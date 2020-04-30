class ProductListModel  {
  int pageIndex;
  int total;
  List<DatasListBean> datas;

  ProductListModel({this.pageIndex, this.total, this.datas});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    this.pageIndex = json['page_index'];
    this.total = json['total'];
    this.datas = (json['datas'] as List) != null
        ? (json['datas'] as List).map((i) => DatasListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_index'] = this.pageIndex;
    data['total'] = this.total;
    data['datas'] =
        this.datas != null ? this.datas.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class DatasListBean {
  String id;
  String cateId;
  String image;
  String title;
  String price;
  List<String> tags;

  DatasListBean(
      {this.id, this.cateId, this.image, this.title, this.price, this.tags});

  DatasListBean.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.cateId = json['cate_id'];
    this.image = json['image'];
    this.title = json['title'];
    this.price = json['price'];

    List<dynamic> tagsList = json['tags'];
    this.tags = new List();
    this.tags.addAll(tagsList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cate_id'] = this.cateId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['tags'] = this.tags;
    return data;
  }
}
