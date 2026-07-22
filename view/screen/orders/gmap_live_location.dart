import 'dart:async';
import 'dart:convert';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:almithaq/view/widget/orders/etacard.dart';
import 'package:almithaq/view/screen/orders/gmap_pick_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class GmapLiveLocation extends StatefulWidget {
  const GmapLiveLocation({super.key});

  @override
  State<GmapLiveLocation> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GmapLiveLocation> {
  final locationController = Location();

  double userLat = Get.arguments['user_lat'];
  double userLong = Get.arguments['user_long'];
  double delvLat = Get.arguments['del_lat'];
  double delvLong = Get.arguments['del_long'];

  LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};
  String eta = "--";
  String distance = "--";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
    currentPosition = LatLng(
            delvLat,
            delvLong,
          );
    calculateETA();
  }

  Future<void> initializeMap() async {
    await fetchLocationUpdates();
    final coordinates = await fetchPolylinePoints();
    generatePolyLineFromPoints(coordinates);
  }


  Future<void> calculateETA() async {
    // We calculate the route from Delivery Boy (origin) to User (destination)
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$delvLat,$delvLong&destination=$userLat,$userLong&key=$kGoogleApiKey';

    try {
      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);

      if (data['status'] == 'OK' && mounted) {
        setState(() {
          eta = data['routes'][0]['legs'][0]['duration']['text'];
          distance = data['routes'][0]['legs'][0]['distance']['text'];
        });
      }
    } catch (e) {
      print("Error calculating ETA: $e");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: currentPosition == null
            ? const Center(child: CircularProgressIndicator(color: AppColor.primaryColor,))
            : Stack(
              children: [
                GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(delvLat, delvLong),
                      zoom: 13,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('sourceLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(delvLat, delvLong),
                      ),
                      Marker(
                        markerId: MarkerId('destinationLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(userLat, userLong),
                      )
                    },
                    polylines: Set<Polyline>.of(polylines.values),
                  ),
                  EtaCard(distance: distance, eta: eta),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: CustomButtomAuth(text: "عودة", onPressed: () {
                      Get.back();
                    },),
                  )
              ],
            ),
      );

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints(apiKey: 'AIzaSyA7xC-9zwwtWezEZ0pkbx7i5dijkzuk2_s');

    final result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(delvLat, delvLong), 
        destination: PointLatLng(userLat, userLong), 
        mode: TravelMode.driving),
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      print("ERORRRRRRRRRRRRRRR ${result.errorMessage}");
      return [];
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() => polylines[id] = polyline);
  }
}