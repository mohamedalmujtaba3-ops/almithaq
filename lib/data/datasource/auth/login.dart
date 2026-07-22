import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  postdata(String phone ,String password) async {
    var response = await crud.postData(AppLink.login, {
      "phone" : phone , 
      "password" : password   
    });
    return response.fold((l) => l, (r) => r);
  }
}
