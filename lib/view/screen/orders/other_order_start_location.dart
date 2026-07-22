import 'dart:convert';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/constant/routes.dart';
import 'package:almithaq/core/functions/citybounds.dart';
import 'package:almithaq/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const kGoogleApiKey = "AIzaSyA7xC-9zwwtWezEZ0pkbx7i5dijkzuk2_s"; 

class OtherOrderStartingLocation extends StatefulWidget {
  const OtherOrderStartingLocation({super.key});

  @override
  State<OtherOrderStartingLocation> createState() => _StartingModernLocationPickerState();
}

class _StartingModernLocationPickerState extends State<OtherOrderStartingLocation> {

  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  LatLng? _selectedLocation;
  bool _isLoading = true;
  Set<Marker> _markers = {};

  StatusRequest statusRequest = StatusRequest.none;
  String address = "";

  @override
  void initState() {
    super.initState();
    _getUserCurrentLocation();
    if(_selectedLocation != null) {
      _updateMarkerAndVariables(_selectedLocation!);
    }
  }


  // تحديث الدبوس وقيم المتغيرات في نفس الوقت
  void _updateMarkerAndVariables(LatLng newPosition) {
    setState(() {
      _selectedLocation = newPosition; // هنا يتم إسناد خطوط الطول والعرض للمتغيرات مباشرة
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: newPosition,
          infoWindow: const InfoWindow(title: 'الموقع المختار'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        )
      };
    });
  }

  // 1. Get location using the latest geolocator syntax
  Future<void> _getUserCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _selectedLocation = _currentPosition;
      _isLoading = false;
      _updateMarkerAndVariables(_currentPosition!);
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition!, zoom: 16),
      ),
    );
  }

  // 2. Direct HTTP call for Places Autocomplete
  Future<List<Map<String, dynamic>>> _searchPlaces(String query) async {
    if (query.isEmpty) return [];
    
    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      {
        'input': query,
        'location': '${_selectedLocation!.latitude},${_selectedLocation!.longitude}',
        'radius': '50000',
        'strictbounds': 'true', // blocking outside of city results
        'key': kGoogleApiKey,
        'language': 'ar', // forces Arabic results (remove if not needed)
      },
    );
    
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return List<Map<String, dynamic>>.from(data['predictions']);
      }
    }
    return [];
  }

  // 3. Direct HTTP call to get Lat/Lng from Place ID
  Future<void> _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$kGoogleApiKey'
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['result']['geometry']['location'];
        final latLng = LatLng(location['lat'], location['lng']);
        
        setState(() => _selectedLocation = latLng);
        
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 16),
          ),
        );
        _updateMarkerAndVariables(latLng);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLngBounds cityBounds = CityBounds();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 237, 237, 237),
        elevation: 0.0,
        title: Text("مكان الطلب",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColor.primaryColor, fontSize: 20)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false, // Hidden to avoid UI overlap
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => _mapController = controller,
                  onCameraMove: (position) {
                    _selectedLocation = position.target;
                  },
                  cameraTargetBounds: CameraTargetBounds(cityBounds),
                  minMaxZoomPreference: const MinMaxZoomPreference(11.0, 18.0), // لمنع المستخدم من التصغير الشديد فيتجاوز حدود مدينته
                  markers: _markers,
                  onTap: (LatLng tappedPoint) {
                    _updateMarkerAndVariables(tappedPoint);
                  },
                ),

                // Material 3 Native Search Bar
                Positioned(
                  top: 10,
                  left: 16,
                  right: 16,
                  child: SearchAnchor.bar(
                    barHintText: 'البحث عن مكان',
                    barElevation: MaterialStateProperty.all(2),
                    suggestionsBuilder: (context, controller) async {
                      final predictions = await _searchPlaces(controller.text);
                      
                      return predictions.map((place) => ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(place['description']),
                        onTap: () {
                          controller.closeView(place['description']);
                          FocusScope.of(context).unfocus();
                          _getPlaceDetails(place['place_id']);
                        },
                      )).toList();
                    },
                  ),
                ),

                // My Location FAB
                Positioned(
                  bottom: 100,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onPressed: _getUserCurrentLocation,
                    child: Icon(
                      Icons.my_location,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                // Confirm Button
                Positioned(
                  bottom: 30,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin:const EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          onPressed: () {
                            Get.back();
                          }, 
                          color: const Color.fromARGB(255, 161, 161, 161), 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding:const EdgeInsets.symmetric(vertical: 13),
                          child: const Text("رجوع", style: TextStyle(color: Colors.white),), 
                        ),
                      ),
                      SizedBox(width: 5,),
                      CustomButtomAuth( text: "تم التحديد",
                        onPressed: () {
                          double lat = _selectedLocation!.latitude;
                          double long = _selectedLocation!.longitude;
                          Get.toNamed(AppRoute.otherorderdestlocation, arguments: {
                            "lat" : lat,
                            "long" : long
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}