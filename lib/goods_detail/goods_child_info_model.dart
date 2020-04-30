class GoodsChildInfoModel {
  String title;
  String info;
  String price;
  String oldPrice;

  GoodsChildInfoModel({this.title, this.info, this.price, this.oldPrice});

  GoodsChildInfoModel.fromJson(Map<String, dynamic> json) {    
    this.title = json['title'];
    this.info = json['info'];
    this.price = json['price'];
    this.oldPrice = json['old_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['info'] = this.info;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    return data;
  }

}
