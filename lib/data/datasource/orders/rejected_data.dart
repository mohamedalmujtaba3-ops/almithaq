import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class OrdersRejectedData {
  Crud crud;
  OrdersRejectedData(this.crud);
  getData(String userid) async {
    var response = await crud.postData(AppLink.oredersrejected, {"id": userid});
    return response.fold((l) => l, (r) => r);
  }
}
