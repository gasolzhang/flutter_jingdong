class GoodsSpecNameModel  {
  String name;
  String specName;

  GoodsSpecNameModel({this.name, this.specName});

  GoodsSpecNameModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.specName = json['spec_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['spec_name'] = this.specName;
    return data;
  }

}
