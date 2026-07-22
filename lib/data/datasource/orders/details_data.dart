import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class OrdersDetailsData {
  Crud crud;
  OrdersDetailsData(this.crud);

  getData(String id, String dep) async {
    var response = await crud.postData(AppLink.ordersdetails, {"id": id, "dep": dep});
    return response.fold((l) => l, (r) => r);
  }


  setDone(String orderid, String delvid, String rating) async {
    var response = await crud.postData(AppLink.setdone, {"orderid": orderid, "delvid": delvid, "rating": rating });
    return response.fold((l) => l, (r) => r);
  }

}
