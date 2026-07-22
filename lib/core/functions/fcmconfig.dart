import 'package:almithaq/controller/orders/archive_controller.dart';
import 'package:almithaq/controller/orders/pending_controller.dart';
import 'package:almithaq/controller/wallet/wallet_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

requestPermissionNotification() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

fcmconfig() {
  FlutterRingtonePlayer flutterringtoneplayer = FlutterRingtonePlayer();
  FirebaseMessaging.onMessage.listen((message) {
    print(message.notification!.title);
    print(message.notification!.body);
    flutterringtoneplayer.playNotification();
    Get.snackbar(message.notification!.title!, message.notification!.body!);
    refreshPageNotification(message.data);
  });
}

refreshPageNotification(data) {
  print("============================= page id ");
  print(data['pageid']);
  print("============================= page name ");
  print(data['pagename']);
  print("================== Current Route");
  print(Get.currentRoute);

  if (Get.currentRoute == "/pending" &&
      data['pagename'] == "refreshorderspending") {
    OrdersPendingController controller = Get.find();
    controller.refrehOrder();
  }
  if (Get.currentRoute == "/archive" &&
      data['pagename'] == "refreshordersarchive") {
    OrdersArchiveController controller = Get.find();
    controller.refrehOrder();
  }
  if (Get.currentRoute == "/wallet_screen" &&
      data['pagename'] == "refreshwallet") {
    WalletController controller = Get.find();
    controller.loadWallet();
  }

}


// Firebase + stream 
// Socket io 
// Notification refresh 