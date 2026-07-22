class TestModel {
  String? usersId;
  String? usersName;
  String? usersPassword;
  String? usersPhone;
  String? usersCity;
  String? usersVerfiycode;
  String? usersApprove;
  String? usersCreate;

  TestModel(
      {this.usersId,
      this.usersName,
      this.usersPassword,
      this.usersPhone,
      this.usersCity,
      this.usersVerfiycode,
      this.usersApprove,
      this.usersCreate});

  TestModel.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersPassword = json['users_password'];
    usersPhone = json['users_phone'];
    usersCity = json['users_city'];
    usersVerfiycode = json['users_verfiycode'];
    usersApprove = json['users_approve'];
    usersCreate = json['users_create'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['users_id'] = this.usersId;
  //   data['users_name'] = this.usersName;
  //   data['users_password'] = this.usersPassword;
  //   data['users_email'] = this.usersEmail;
  //   data['users_phone'] = this.usersPhone;
  //   data['users_verfiycode'] = this.usersVerfiycode;
  //   data['users_approve'] = this.usersApprove;
  //   data['users_create'] = this.usersCreate;
  //   return data;
  // }
}