class CategorySeccondModel {
  List<DatasListBean> datas;

  CategorySeccondModel({this.datas});

  CategorySeccondModel.fromJson(Map<String, dynamic> json) {
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
  String image;
  int type;

  DatasListBean({this.id, this.name, this.image, this.type});

  DatasListBean.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.image = json['image'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
