class GoodsSpecContentModel{
  List<String> specs;

  GoodsSpecContentModel({this.specs});

  GoodsSpecContentModel.fromJson(Map<String, dynamic> json) {    

    List<dynamic> specsList = json['specs'];
    this.specs = new List();
    this.specs.addAll(specsList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specs'] = this.specs;
    return data;
  }

}
