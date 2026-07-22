import 'dart:io';

import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class CheckoutData {
  Crud crud;
  CheckoutData(this.crud);

  
  checkout(Map data) async {
    var response = await crud.postData(AppLink.checkout, data);
    return response.fold((l) => l, (r) => r);
  }

  deliveryPriceData() async {
    var response =
        await crud.postData(AppLink.delvprice, {"noEffect": "1"});
    return response.fold((l) => l, (r) => r);
  }

  addOtherOrder(String usersid, String desc, String start_lat, String start_long, String dest_lat, String dest_long, String address, String deliveryprice, String city) async {
    Map data = {
      "usersid": usersid,
      "desc": desc,
      "address": address,
      "start_lat": start_lat,
      "start_long": start_long,
      "dest_lat": dest_lat,
      "dest_long": dest_long,
      "delivery_price": deliveryprice,
      "city": city,
    };
    var response = await crud.postData(AppLink.addotherorder, data);
    return response.fold((l) => l, (r) => r);
  }

  addPharmOrder(String usersid, String medstext, String notes, String lat, String long, String address, String city) async {
    Map data = {
      "usersid": usersid,
      "medstext": medstext,
      "notes": notes,
      "address": address,
      "lat": lat,
      "long": long,
      "city": city,
    };
    var response = await crud.postData(AppLink.addpharmorder, data);
    return response.fold((l) => l, (r) => r);
  }

  addPharmOrderRousheta(String usersid, String notes, String lat, String long, String address, String city, File rousheta) async {
    Map data = {
      "usersid": usersid,
      "notes": notes,
      "address": address,
      "lat": lat,
      "long": long,
      "city": city,
    };
    var response = await crud.postDataWithOneFile(AppLink.addpharmorder, data, rousheta);
    return response.fold((l) => l, (r) => r);
  }

}
