class ItemsModel {
  String? itemsId;
  String? itemsName;
  String? itemsDesc;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsDate;
  String? itemsCat;
  String? itemsRating;
  String? sellerId;
  String? sellerName;
  String? sellerLogo;  
  String? sellerType;
  String? sellerAddress;
  String? sellerCity;
  String? sellerRating;
  String? sellerStatus;

  ItemsModel(
      {this.itemsId,
      this.itemsName,
      this.itemsDesc,
      this.itemsImage,
      this.itemsCount,
      this.itemsActive,
      this.itemsPrice,
      this.itemsDiscount,
      this.itemsDate,
      this.itemsCat,
      this.itemsRating,
      this.sellerId,
      this.sellerName,
      this.sellerLogo,
      this.sellerType,
      this.sellerAddress,
      this.sellerCity,
      this.sellerRating,
      this.sellerStatus,});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'].toString();
    itemsName = json['items_name'];
    itemsDesc = json['items_desc'];
    itemsImage = json['items_image'];
    itemsCount = json['items_count'].toString();
    itemsActive = json['items_active'].toString();
    itemsPrice = json['items_price'].toString();
    itemsDiscount = json['items_discount'].toString();
    itemsDate = json['items_date'].toString();
    itemsCat = json['items_seller'].toString();
    itemsRating = json['items_rating'].toString();
    sellerId = json['seller_id'].toString();
    sellerName = json['seller_name'].toString();
    sellerLogo = json['seller_logo'].toString();
    sellerType = json['seller_type'].toString();
    sellerAddress = json['seller_address'].toString();
    sellerCity = json['seller_city'].toString();
    sellerRating = json['seller_rating'].toString();
    sellerStatus = json['seller_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_name'] = this.itemsName;
    data['items_desc'] = this.itemsDesc;
    data['items_image'] = this.itemsImage;
    data['items_count'] = this.itemsCount;
    data['items_active'] = this.itemsActive;
    data['items_price'] = this.itemsPrice;
    data['items_discount'] = this.itemsDiscount;
    data['items_date'] = this.itemsDate;
    data['items_seller'] = this.itemsCat;
    data['items_rating'] = this.itemsRating;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['seller_logo'] = this.sellerLogo;
    data['seller_type'] = this.sellerType;
    data['seller_address'] = this.sellerAddress;
    data['seller_city'] = this.sellerCity;
    data['seller_rating'] = this.sellerRating;
    data['seller_status'] = this.sellerStatus;
    return data;
  }
}
