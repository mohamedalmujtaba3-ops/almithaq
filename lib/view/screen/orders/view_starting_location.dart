import 'package:almithaq/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as slpMap;
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as coordinates;
import 'package:latlong2/latlong.dart';

class ViewLocation extends StatefulWidget {
  final Color appBarColor;

  final Color markerColor;

  final Color appBarTextColor;

  final String appBarTitle;

  final double lat1 = double.parse(Get.arguments['lat']);
  final double long1 = double.parse(Get.arguments['long']);

  ViewLocation({super.key, 
    this.appBarColor = AppColor.primaryColor,
    this.appBarTextColor = Colors.white,
    this.appBarTitle = "موقعك",
    this.markerColor = AppColor.primaryColor,
  });

  @override
  _ViewLocationState createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {
  // Holds the value of the picked location.
  // late ViewLocationResult _selectedLocation;

  // void initState() {
  //   super.initState();
  //   _selectedLocation = ViewLocationResult(
  //     widget.initialLatitude,
  //     widget.initialLongitude,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: widget.appBarColor,
        title: Text(widget.appBarTitle,
            style: TextStyle(color: widget.appBarTextColor, fontSize: 20)),
      ),
      body: _osmWidget(),
    );
  }

  /// Returns a widget containing the openstreetmaps screen.
  Widget _osmWidget() {
    return slpMap.FlutterMap(
      options: slpMap.MapOptions(
          initialCenter:
              coordinates.LatLng(ViewLocation().lat1, ViewLocation().long1),
          initialZoom: 14,
          onTap: (tapPosition, latLng) {
            print(
                "${coordinates.LatLng(ViewLocation().lat1, ViewLocation().long1)}");
          }),
      children: [
        slpMap.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'client.almithaq.delivery',
          tileProvider: CancellableNetworkTileProvider(
            silenceExceptions: true,
          ),
          tileBounds: slpMap.LatLngBounds(const LatLng(19.52982050933457, 37.26271173758944), const LatLng(19.697666133570273, 37.12572597283279)),
        ),
        slpMap.MarkerLayer(
          markers: [
            slpMap.Marker(
                width: 40.0,
                height: 40.0,
                alignment: Alignment.topCenter,
                point: coordinates.LatLng(
                    ViewLocation().lat1, ViewLocation().long1),
                child: Icon(
                  Icons.room,
                  size: 40,
                  color: widget.markerColor,
                  shadows: [
                    BoxShadow(
                        color: const Color.fromARGB(196, 0, 0, 0),
                        offset: Offset.fromDirection(1, 2.0),
                        blurRadius: 6,
                        spreadRadius: 3)
                  ],
                ))
          ],
        )
      ],
    );
  }
}
