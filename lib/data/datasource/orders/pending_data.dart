import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class OrdersPendingData {
  Crud crud;
  OrdersPendingData(this.crud);
  getData(String userid, {int offset = 0}) async {
    var response = await crud.postData(AppLink.pendingorders, {"id": userid, "offset": offset.toString()});
    return response.fold((l) => l, (r) => r);
  }
  deleteData(String orderid) async {
    var response = await crud.postData(AppLink.ordersdelete, {"id": orderid});
    return response.fold((l) => l, (r) => r);
  }
}
