import 'package:almithaq/core/constant/color.dart';
import 'package:almithaq/core/functions/citybounds.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyA7xC-9zwwtWezEZ0pkbx7i5dijkzuk2_s"; 

class GmapViewLocation extends StatefulWidget {
  const GmapViewLocation({super.key});

  @override
  State<GmapViewLocation> createState() => _ModernLocationViewerState();
}

class _ModernLocationViewerState extends State<GmapViewLocation> {

  LatLng? _selectedLocation;
  bool _isLoading = true;
  Set<Marker> _markers = {};

  final double lat = double.parse(Get.arguments['lat']);
  final double long = double.parse(Get.arguments['long']);

  @override
  void initState() {
    super.initState();
    _selectedLocation = LatLng(lat, long);
    if(_selectedLocation != null) {
      _updateMarkerAndVariables(_selectedLocation!);
    }
  }


  // تحديث الدبوس وقيم المتغيرات في نفس الوقت
  void _updateMarkerAndVariables(LatLng newPosition) {
    setState(() {
      _selectedLocation = newPosition; // هنا يتم إسناد خطوط الطول والعرض للمتغيرات مباشرة
      _isLoading = false;
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

  


  @override
  Widget build(BuildContext context) {
    final LatLngBounds cityBounds = CityBounds();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 237, 237, 237),
        elevation: 0.0,
        title: Text("عرض",
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
                    target: LatLng(lat, long),
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false, // Hidden to avoid UI overlap
                  zoomControlsEnabled: false,
                  onCameraMove: (position) {
                    _selectedLocation = position.target;
                  },
                  cameraTargetBounds: CameraTargetBounds(cityBounds),
                  minMaxZoomPreference: const MinMaxZoomPreference(11.0, 18.0), // لمنع المستخدم من التصغير الشديد فيتجاوز حدود مدينته
                  markers: _markers,
                ),


               
              ],
            ),
    );
  }
}