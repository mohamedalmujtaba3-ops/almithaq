import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';


class CartData {
  Crud crud;
  CartData(this.crud);
  
  addCart(String usersid, String itemsid, String sellerid) async {
    var response = await crud
        .postData(AppLink.cartadd, {"id": usersid, "itemsid": itemsid, "sellerid" : sellerid});
    return response.fold((l) => l, (r) => r);
  }


  deleteCart(String usersid, String itemsid) async {
    var response = await crud
        .postData(AppLink.cartdelete, {"usersid": usersid, "itemsid": itemsid});
    return response.fold((l) => l, (r) => r);
  }


  getCountCart(String usersid, String itemsid) async {
    var response = await crud.postData(
        AppLink.cartgetcountitems, {"usersid": usersid, "itemsid": itemsid});
    return response.fold((l) => l, (r) => r);
  }


  viewCart(String usersid) async {
    var response = await crud.postData(AppLink.cartview, {
      "id": usersid,
    });
    return response.fold((l) => l, (r) => r);
  }


}
