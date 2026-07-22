import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class OrdersArchiveData {
  Crud crud;
  OrdersArchiveData(this.crud);
  getData(String userid, {int offset = 0}) async {
    var response = await crud.postData(AppLink.ordersarchive, {"id": userid, "offset": offset.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
