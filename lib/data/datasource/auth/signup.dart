import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);
  postdata(String username, String password, String phone, String city ) async {
    var response = await crud.postData(AppLink.signUp, {
      "username" : username , 
      "password" : password  , 
      "phone" : phone  , 
      "city" : city  , 
    });
    return response.fold((l) => l, (r) => r);
  }
}
