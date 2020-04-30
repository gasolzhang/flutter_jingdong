class GoodsChildBannerModel {
  List<String> images;

  GoodsChildBannerModel({this.images});

  GoodsChildBannerModel.fromJson(Map<String, dynamic> json) {    

    List<dynamic> imagesList = json['images'];
    this.images = new List();
    this.images.addAll(imagesList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    return data;
  }

}
