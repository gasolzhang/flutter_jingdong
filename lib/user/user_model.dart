class UserModel {
  String ID;
  String Phone;
  String Name;
  String Avatar;
  String Sign;
  String Token;

  UserModel({this.ID, this.Phone, this.Name, this.Avatar, this.Sign, this.Token});

  UserModel.fromJson(Map<String, dynamic> json) {    
    this.ID = json['ID'];
    this.Phone = json['Phone'];
    this.Name = json['Name'];
    this.Avatar = json['Avatar'];
    this.Sign = json['Sign'];
    this.Token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['Phone'] = this.Phone;
    data['Name'] = this.Name;
    data['Avatar'] = this.Avatar;
    data['Sign'] = this.Sign;
    data['Token'] = this.Token;
    return data;
  }

}
