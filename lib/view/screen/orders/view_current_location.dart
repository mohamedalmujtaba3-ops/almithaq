import 'dart:async';
import 'dart:convert';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/data/datasource/orders/getdelvlocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart' as slpMap;
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as coordinates;
import 'package:location/location.dart';


class ViewCurrentLocation extends StatefulWidget {

  final Color appBarColor;
  final Color markerColor;
  final Color appBarTextColor;
  final String appBarTitle;

  ViewCurrentLocation({super.key, 
    this.appBarColor = AppColor.primaryColor,
    this.appBarTextColor = Colors.white,
    this.appBarTitle = "التحرك",
    this.markerColor = AppColor.primaryColor,
  });

  @override
  _ViewCurrentLocationState createState() => _ViewCurrentLocationState();

}



class _ViewCurrentLocationState extends State<ViewCurrentLocation> {

  StatusRequest statusRequest = StatusRequest.none;
  final String orderid = Get.arguments['orderid'];
  final double lat1 = double.parse(Get.arguments['lat']);
  final double long1 = double.parse(Get.arguments['long']);
  late double latDel;
  late double longDel;
  UpdateDelvLocation locationFromDB = UpdateDelvLocation(Get.find());
  late Map locationMap;
  coordinates.LatLng? _currentLocation;
  Location? location = Location();
  late StreamSubscription locating;
  List<coordinates.LatLng> points = [];
  List listofpoints = [];
  Timer? timer;
  static const String baseUrl = 'https://api.openrouteservice.org/v2/directions/driving-car';
  static const String apiKey = '5b3ce3597851110001cf6248f309afd3315846b0a94a169eb5c7cf58';

  getRouteUrl(String startPoint, String endPoint){
    return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint&p');
  }



  Future<void> _getCurrentLocation() async {
    var response = await locationFromDB.UpdateLocation(orderid);
    print("=============================== Controller $response ");
      // Start backend
      if (response['status'] == "success") {
        latDel = double.parse(response['data']['orders_del_lat']);
        longDel = double.parse(response['data']['orders_del_long']);
      } else {
        Get.snackbar("إتصال ضعيف", "جودة الإتصال بالإنترنت ضعيفة");
      }
      // End
    setState(() {
      _currentLocation = coordinates.LatLng(latDel, longDel);
    });
  }


  currentCoordinates() {
    return setState(() {
      coordinates.LatLng(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
    );
    });
    
  }






  drawRoute() async {
    // Requesting for openrouteservice api
    var response = await http.get(getRouteUrl("${_currentLocation!.longitude},${_currentLocation!.latitude}",
        '$long1,$lat1'));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listofpoints = data['features'][0]['geometry']['coordinates'];
        points = listofpoints
            .map((p) => coordinates.LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      }
    });
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: widget.appBarColor,
        title: Text(widget.appBarTitle,
            style: TextStyle(color: widget.appBarTextColor, fontSize: 20)),
      ),
      body: slpMap.FlutterMap(
        options: slpMap.MapOptions(
          onMapReady: () {
            drawRoute();
          },
          onPositionChanged:(camera, hasGesture) {
            setState(() {
              slpMap.MapCamera.initialCamera(slpMap.MapOptions(initialCenter: new coordinates.LatLng(
                _currentLocation!.latitude,
                _currentLocation!.longitude,
              ),));
            });
          },
          initialCenter: new coordinates.LatLng(
            _currentLocation!.latitude,
            _currentLocation!.longitude,
          ),
          initialZoom: 14.0,
        ),
        children: [
          slpMap.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          tileProvider: CancellableNetworkTileProvider(
            silenceExceptions: true,
          ),
          tileBounds: slpMap.LatLngBounds(const coordinates.LatLng(19.52982050933457, 37.26271173758944), const coordinates.LatLng(19.697666133570273, 37.12572597283279)),
          ),
          slpMap.MarkerLayer(
            markers: [
              slpMap.Marker(
                width: 38.0,
                height: 38.0,
                alignment: Alignment.topCenter,
                point: coordinates.LatLng(
                  _currentLocation!.latitude,
                  _currentLocation!.longitude,
                ),
                child: Icon(
                  Icons.room,
                  size: 38,
                  color: widget.markerColor,
                  shadows: [
                    BoxShadow(
                        color: const Color.fromARGB(196, 0, 0, 0),
                        offset: Offset.fromDirection(1, 2.0),
                        blurRadius: 6,
                        spreadRadius: 3)
                  ],
                ),
              ),
              slpMap.Marker(
                width: 35.0,
                height: 35.0,
                alignment: Alignment.topCenter,
                point: coordinates.LatLng(
                  lat1,
                  long1,
                ),
                child: Icon(
                  Icons.room,
                  size: 35,
                  color: const Color.fromARGB(255, 167, 0, 39),
                  shadows: [
                    BoxShadow(
                        color: const Color.fromARGB(196, 0, 0, 0),
                        offset: Offset.fromDirection(1, 2.0),
                        blurRadius: 6,
                        spreadRadius: 3)
                  ],
                ),
              ),
            ],
          ),
          slpMap.PolylineLayer(
                polylines: [
                  slpMap.Polyline(
                    points: points,
                    color: const Color.fromARGB(255, 0, 98, 178),
                    strokeWidth: 5,
                  ),
                ],
              ),
        ],
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    drawRoute();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => _getCurrentLocation());
  }



  @override
  void dispose() {
    _currentLocation = null;
    timer!.cancel();
    locating.asFuture().ignore();
    locating.pause();
    locating.cancel();
    super.dispose();
  }


}
