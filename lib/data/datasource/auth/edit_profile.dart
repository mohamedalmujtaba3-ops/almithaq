import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';


class ProfileData {
  Crud crud;
  ProfileData(this.crud);



  editProfileData(String userid, String username, String password, String phone, String city) async {
    var response = await crud.postData(AppLink.editprofile, {
      "id" : userid,
      "username" : username, 
      "password" : password,
      "phone" : phone,
      "city" : city,  
    });
    return response.fold((l) => l, (r) => r);
  }


}
