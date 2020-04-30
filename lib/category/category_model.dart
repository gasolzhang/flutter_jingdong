class CategoryModel {
  List<DatasListBean> datas;

  CategoryModel({this.datas});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    this.datas = (json['datas'] as List) != null
        ? (json['datas'] as List).map((i) => DatasListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datas'] =
        this.datas != null ? this.datas.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class DatasListBean {
  String id;
  String name;
  int type;

  DatasListBean({this.id, this.name, this.type});

  DatasListBean.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
