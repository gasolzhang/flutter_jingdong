class HomeBannerModel {
  List<BannerListBean> Banner;

  HomeBannerModel({this.Banner});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {    
    this.Banner = (json['Banner'] as List)!=null?(json['Banner'] as List).map((i) => BannerListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Banner'] = this.Banner != null?this.Banner.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class BannerListBean {
  String Image;
  String Action;

  BannerListBean({this.Image, this.Action});

  BannerListBean.fromJson(Map<String, dynamic> json) {    
    this.Image = json['Image'];
    this.Action = json['Action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Image'] = this.Image;
    data['Action'] = this.Action;
    return data;
  }
}
