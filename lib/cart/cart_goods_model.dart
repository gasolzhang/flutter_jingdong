class CartGoodsModel {
  String id;
  String shop;
  String image;
  String title;
  String specs;
  String price;
  bool checked = false;
  int count;

  CartGoodsModel(
      {this.id,
      this.shop,
      this.image,
      this.title,
      this.specs,
      this.price,
      this.checked,
      this.count});

  CartGoodsModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.shop = json['shop'];
    this.image = json['image'];
    this.title = json['title'];
    this.specs = json['specs'];
    this.price = json['price'];
    this.checked = json['checked'];
    this.count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop'] = this.shop;
    data['image'] = this.image;
    data['title'] = this.title;
    data['specs'] = this.specs;
    data['price'] = this.price;
    data['checked'] = this.checked;
    data['count'] = this.count;
    return data;
  }
}
