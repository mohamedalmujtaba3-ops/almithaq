// import 'package:almithaq/controller/checkout_controller.dart';
// import 'package:almithaq/controller/orders/pick_location_controller.dart';
// import 'package:almithaq/core/class/statusrequest.dart';
// import 'package:almithaq/core/constant/color.dart';
// import 'package:almithaq/core/constant/map_constants.dart';
// import 'package:almithaq/core/functions/validinput.dart';
// import 'package:almithaq/view/widget/auth/customtextformauth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart' as slpMap;
// import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:latlong2/latlong.dart';

// class SimpleLocationPicker extends StatefulWidget {
//   final double initialLatitude;
//   final double initialLongitude;

//   final double zoomLevel;

//   /// Sets the mode of the picker.
//   /// if true: enables DisplayOnly mode to display a marker on the map at a location only, no selection
//   /// if false: enabled Picker mode allows to tap on the map to pick a location
//   final bool displayOnly;

//   final Color appBarColor;

//   final Color markerColor;

//   final Color appBarTextColor;

//   final String appBarTitle;

//   SimpleLocationPicker({
//     this.initialLatitude = SLPConstants.DEFAULT_LATITUDE,
//     this.initialLongitude = SLPConstants.DEFAULT_LONGITUDE,
//     this.zoomLevel = SLPConstants.DEFAULT_ZOOM_LEVEL,
//     this.displayOnly = false,
//     this.appBarColor = AppColor.primaryColor,
//     this.appBarTextColor = Colors.white,
//     this.appBarTitle = "حدد الموقع",
//     this.markerColor = AppColor.primaryColor,
//   });

//   @override
//   _SimpleLocationPickerState createState() => _SimpleLocationPickerState();
// }

// class _SimpleLocationPickerState extends State<SimpleLocationPicker> {
//   // Holds the value of the picked location.
//   late SimpleLocationResult _selectedLocation;

//   StatusRequest statusRequest = StatusRequest.none;

//   CheckoutController checkoutController = Get.put(CheckoutController());

//   final String orderprice = Get.arguments['priceorder'];

//   void initState() {
//     super.initState();
//     _selectedLocation = SimpleLocationResult(
//       widget.initialLatitude,
//       widget.initialLongitude,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: widget.appBarColor,
//         title: Text(widget.appBarTitle,
//             style: TextStyle(color: widget.appBarTextColor, fontSize: 20)),
//         actions: <Widget>[
//           // DISPLAY_ONLY MODE: no save button for display only mode
//           widget.displayOnly
//               ? Container()
//               : IconButton(
//                   icon: const Icon(
//                     Icons.keyboard_double_arrow_left_rounded,
//                     size: 28,
//                     weight: 900,
//                   ),
//                   onPressed: () {
//                     Get.defaultDialog(
//                         title: "العنوان كتابة",
//                         content: CustomTextFormAuth(
//                           isNumber: false,
//                           valid: (val) {
//                             return validInput(val!, 20, 60, "username");
//                           },
//                           mycontroller: checkoutController.address,
//                           hinttext: "وصف المنزل بصورة واضحة مختصرة",
//                           iconData: Icons.email_outlined,
//                           labeltext: "وصف المنزل",
//                         ),
//                         buttonColor: AppColor.primaryColor,
//                         textConfirm: "إرسال الطلب",
//                         onConfirm: () {
//                           double lat = _selectedLocation.latitude;
//                           double long = _selectedLocation.longitude;
//                           if (lat != widget.initialLatitude &&
//                               long != widget.initialLongitude) {
//                             checkoutController.deliveryPrice(
//                               lat,
//                               long,
//                               orderprice.toString(),
//                             );
//                           } else {
//                             Get.snackbar("خطأ", "الرجاء تحديد الموقع");
//                           }
//                         },
//                         textCancel: "إلغاء",
//                         onCancel: () {
//                           Get.back();
//                         });
//                   },
//                   color: widget.appBarTextColor,
//                 ),
//         ],
//       ),
//       body: _osmWidget(),
//     );
//   }

//   /// Returns a widget containing the openstreetmaps screen.
//   Widget _osmWidget() {
//     return slpMap.FlutterMap(
//       options: slpMap.MapOptions(
//           initialCenter: _selectedLocation.getLatLng(),
//           initialZoom: widget.zoomLevel,
//           onTap: (tapPosition, latLng) {
//             // DISPLAY_ONLY MODE: no map taps for display only mode
//             if (!widget.displayOnly) {
//               setState(() {
//                 _selectedLocation =
//                     SimpleLocationResult(latLng.latitude, latLng.longitude);
//               });
//             }
//           }),
//       children: [
//         slpMap.TileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           userAgentPackageName: 'client.almithaq.delivery',
//           tileProvider: CancellableNetworkTileProvider(
//             silenceExceptions: true,
//           ),
//           tileBounds: slpMap.LatLngBounds(
//               const LatLng(19.52982050933457, 37.26271173758944),
//               const LatLng(19.697666133570273, 37.12572597283279)),
//         ),
//         slpMap.MarkerLayer(
//           markers: [
//             slpMap.Marker(
//                 width: 40.0,
//                 height: 40.0,
//                 alignment: Alignment.topCenter,
//                 point: _selectedLocation.getLatLng(),
//                 child: Icon(
//                   Icons.room,
//                   size: 40,
//                   color: widget.markerColor,
//                   shadows: [
//                     BoxShadow(
//                         color: const Color.fromARGB(196, 0, 0, 0),
//                         offset: Offset.fromDirection(1, 2.0),
//                         blurRadius: 6,
//                         spreadRadius: 3)
//                   ],
//                 ))
//           ],
//         )
//       ],
//     );
//   }
// }
