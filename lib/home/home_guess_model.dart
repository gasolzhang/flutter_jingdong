class HomeGuessModel {
  List<GuessListBean> Guess;

  HomeGuessModel({this.Guess});

  HomeGuessModel.fromJson(Map<String, dynamic> json) {    
    this.Guess = (json['Guess'] as List)!=null?(json['Guess'] as List).map((i) => GuessListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Guess'] = this.Guess != null?this.Guess.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class GuessListBean {
  String Image;
  String GoodsId;
  String Price;

  GuessListBean({this.Image, this.GoodsId, this.Price});

  GuessListBean.fromJson(Map<String, dynamic> json) {    
    this.Image = json['Image'];
    this.GoodsId = json['GoodsId'];
    this.Price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Image'] = this.Image;
    data['GoodsId'] = this.GoodsId;
    data['Price'] = this.Price;
    return data;
  }
}
