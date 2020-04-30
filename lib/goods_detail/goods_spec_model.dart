class GoodsSpecModel {
  List<SpecListBean> spec;

  GoodsSpecModel({this.spec});

  GoodsSpecModel.fromJson(Map<String, dynamic> json) {    
    this.spec = (json['spec'] as List)!=null?(json['spec'] as List).map((i) => SpecListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec'] = this.spec != null?this.spec.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class SpecListBean {
  String name;
  List<String> content;

  SpecListBean({this.name, this.content});

  SpecListBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];

    List<dynamic> contentList = json['content'];
    this.content = new List();
    this.content.addAll(contentList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['content'] = this.content;
    return data;
  }
}
