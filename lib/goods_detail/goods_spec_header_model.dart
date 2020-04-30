class GoodsSpecHeaderModel {
  String image;
  String price;
  String number;
  int count;

  GoodsSpecHeaderModel({this.image, this.price, this.number, this.count});

  GoodsSpecHeaderModel.fromJson(Map<String, dynamic> json) {    
    this.image = json['image'];
    this.price = json['price'];
    this.number = json['number'];
    this.count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    data['number'] = this.number;
    data['count'] = this.count;
    return data;
  }

}
