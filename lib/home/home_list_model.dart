class HomeListModel {
  List<GoodsListBean> Goods;

  HomeListModel({this.Goods});

  HomeListModel.fromJson(Map<String, dynamic> json) {    
    this.Goods = (json['Goods'] as List)!=null?(json['Goods'] as List).map((i) => GoodsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Goods'] = this.Goods != null?this.Goods.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class GoodsListBean {
  String ID;
  String Cover;
  String Name;
  String Price;
  String OldPrice;
  String CateId;
  int SaleCount;

  GoodsListBean({this.ID, this.Cover, this.Name, this.Price, this.OldPrice, this.CateId, this.SaleCount});

  GoodsListBean.fromJson(Map<String, dynamic> json) {    
    this.ID = json['ID'];
    this.Cover = json['Cover'];
    this.Name = json['Name'];
    this.Price = json['Price'];
    this.OldPrice = json['OldPrice'];
    this.CateId = json['CateId'];
    this.SaleCount = json['SaleCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['Cover'] = this.Cover;
    data['Name'] = this.Name;
    data['Price'] = this.Price;
    data['OldPrice'] = this.OldPrice;
    data['CateId'] = this.CateId;
    data['SaleCount'] = this.SaleCount;
    return data;
  }
}
