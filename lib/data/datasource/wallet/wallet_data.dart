import 'dart:io';
import 'package:almithaq/core/class/crud.dart';
import 'package:almithaq/linkapi.dart';

class WalletData {
  Crud crud;
  WalletData(this.crud);

  getBalance(String usersid) async {
    var response = await crud.postData(AppLink.walletBalance, {"id": usersid});
    return response.fold((l) => l, (r) => r);
  }

  sendTopupRequest(String usersid, File screenshot) async {
    var response = await crud.postDataWithOneFile(
      AppLink.walletTopup,
      {"id": usersid},
      screenshot,
      "screenshot",
    );
    return response.fold((l) => l, (r) => r);
  }

  transferBalance(String fromid, String toid, String amount) async {
    var response = await crud.postData(AppLink.walletTransfer, {
      "id": fromid,
      "toid": toid,
      "amount": amount,
    });
    return response.fold((l) => l, (r) => r);
  }

  getPrefs() async {
    var response = await crud.postData(AppLink.prefs, {"noEffect": "1"});
    return response.fold((l) => l, (r) => r);
  }
}
