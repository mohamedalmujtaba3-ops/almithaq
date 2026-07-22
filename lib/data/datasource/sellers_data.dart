
import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class SellersData {
  Crud crud;
  SellersData(this.crud);
  
  getRestaurants({int offset = 0}) async {
    var response =
        await crud.postData(AppLink.restaurants, {"noEffect": "1", "offset": offset.toString()});
    return response.fold((l) => l, (r) => r);
  }

  getSupermarkets({int offset = 0}) async {
    var response =
        await crud.postData(AppLink.supermarkets, {"noEffect": "1", "offset": offset.toString()});
    return response.fold((l) => l, (r) => r);
  }

  getPharms() async {
    var response =
        await crud.postData(AppLink.pharmacies, {"noEffect": "1"});
    return response.fold((l) => l, (r) => r);
  }

 
}
