class OrdersModel {
  String? orderId;
  String? orderUsersid;
  String? orderUsername;
  String? orderUserphone;
  String? orderUserphone2;
  String? orderLat;
  String? orderLong;
  String? orderDelId;
  String? orderDelLat;
  String? orderDelLong;
  String? orderDestLat;
  String? orderDestLong;
  String? orderAddress;
  String? orderPricedelivery;
  String? orderPrice;
  String? orderTotalprice;
  String? orderNotes;
  String? orderMedstext;
  String? orderRousheta;
  String? orderStatus;
  String? orderDatetime;

  OrdersModel(
      {this.orderId,
      this.orderUsersid,
      this.orderUsername,
      this.orderUserphone,
      this.orderUserphone2,
      this.orderLat,
      this.orderLong,
      this.orderDelId,
      this.orderDelLat,
      this.orderDelLong,
      this.orderDestLat,
      this.orderDestLong,
      this.orderAddress,
      this.orderPricedelivery,
      this.orderPrice,
      this.orderTotalprice,
      this.orderNotes,
      this.orderMedstext,
      this.orderRousheta,
      this.orderStatus,
      this.orderDatetime });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orders_id'].toString();
    orderUsersid = json['orders_usersid'].toString();
    orderUsername = json['orders_usersname'];
    orderUserphone = json['orders_usersphone'].toString();
    orderUserphone2 = json['orders_usersphone2'].toString();
    orderLat = json['orders_lat'].toString();
    orderLong = json['orders_long'].toString();
    orderDelId = json['orders_delivery'].toString();
    orderDelLat = json['orders_del_lat'].toString();
    orderDelLong = json['orders_del_long'].toString();
    orderDestLat = json['orders_dest_lat'].toString();
    orderDestLong = json['orders_dest_long'].toString();
    orderAddress = json['orders_address'].toString();
    orderPricedelivery = json['orders_pricedelivery'].toString();
    orderPrice = json['orders_price'].toString();
    orderTotalprice = json['orders_totalprice'].toString();
    orderNotes = json['orders_notes'].toString();
    orderMedstext = json['orders_medstext'].toString();
    orderRousheta = json['orders_rousheta'].toString();
    orderStatus = json['orders_status'].toString();
    orderDatetime = json['orders_datetime'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.orderId;
    data['orders_usersid'] = this.orderUsersid;
    data['orders_usersname'] = this.orderUsername;
    data['orders_usersphone'] = this.orderUserphone;
    data['orders_usersphone2'] = this.orderUserphone2;
    data['orders_lat'] = this.orderLat;
    data['orders_long'] = this.orderLong;
    data['orders_del_lat'] = this.orderDelLat;
    data['orders_del_long'] = this.orderDelLong;
    data['orders_dest_lat'] = this.orderDestLat;
    data['orders_dest_long'] = this.orderDestLong;
    data['orders_address'] = this.orderAddress;
    data['orders_pricedelivery'] = this.orderPricedelivery;
    data['orders_price'] = this.orderPrice;
    data['orders_totalprice'] = this.orderTotalprice;
    data['orders_notes'] = this.orderNotes;
    data['orders_medstext'] = this.orderMedstext;
    data['orders_rousheta'] = this.orderRousheta;
    data['orders_status'] = this.orderStatus;
    data['orders_datetime'] = this.orderDatetime;
    return data;
  }
}