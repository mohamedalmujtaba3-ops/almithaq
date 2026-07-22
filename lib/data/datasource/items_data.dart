import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);
  getData(String sellerid, {int offset = 0}) async {
    var response = await crud.postData(AppLink.items, {"id" : sellerid.toString(), "offset": offset.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
