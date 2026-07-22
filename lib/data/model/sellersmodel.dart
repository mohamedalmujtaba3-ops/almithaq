class SellersModel {
  String? sellerId;
  String? sellerName;
  String? sellerLogo;  
  String? sellerType;
  String? sellerPhone;
  String? sellerPassword;
  String? sellerAddress;
  String? sellerLat;
  String? sellerLong;
  String? sellerCity;
  String? sellerRating;
  String? sellerStatus;
  String? sellerDatetime;

  SellersModel(
      {this.sellerId,
      this.sellerName,
      this.sellerLogo,
      this.sellerType,
      this.sellerPhone,
      this.sellerPassword,
      this.sellerAddress,
      this.sellerLat,
      this.sellerLong,
      this.sellerCity,
      this.sellerRating,
      this.sellerStatus,
      this.sellerDatetime });

  SellersModel.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'].toString();
    sellerName = json['seller_name'].toString();
    sellerLogo = json['seller_logo'].toString();
    sellerType = json['seller_type'].toString();
    sellerPhone = json['seller_phone'].toString();
    sellerPassword = json['seller_password'].toString();
    sellerAddress = json['seller_address'].toString();
    sellerLat = json['seller_lat'].toString();
    sellerLong = json['seller_long'].toString();
    sellerCity = json['seller_city'].toString();
    sellerRating = json['seller_rating'].toString();
    sellerStatus = json['seller_status'].toString();
    sellerDatetime = json['seller_create'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['seller_logo'] = this.sellerLogo;
    data['seller_type'] = this.sellerType;
    data['seller_phone'] = this.sellerPhone;
    data['seller_password'] = this.sellerPassword;
    data['seller_address'] = this.sellerAddress;
    data['seller_lat'] = this.sellerLat;
    data['seller_long'] = this.sellerLong;
    data['seller_city'] = this.sellerCity;
    data['seller_rating'] = this.sellerRating;
    data['seller_status'] = this.sellerStatus;
    data['seller_create'] = this.sellerDatetime;
    return data;
  }
}
