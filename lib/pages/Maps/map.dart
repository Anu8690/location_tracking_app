import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapSample extends StatefulWidget {
  final Position currentLocation;
  MapSample({required this.currentLocation});
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final MarkerId markerId = MarkerId("Anurag");

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(26.922070, 75.778885),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // @override
  // void initState() {
  //   super.initState();
  //   final Marker marker = Marker(
  //     markerId: markerId,
  //     position: LatLng(
  //       widget.currentLocation.latitude,
  //       widget.currentLocation.longitude,
  //     ),
  //     infoWindow: InfoWindow(title: "Anurag", snippet: '*'),
  //     // onTap: () {
  //     //   _onMarkerTapped(markerId);
  //     // },
  //   );
  //   markers[markerId] = marker;
  // }

  @override
  Widget build(BuildContext context) {
    Map<MarkerId, Marker> markers = Provider.of<Map<MarkerId, Marker>>(context);
    print('marksers got are ${markers.toString()}');
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition curr = CameraPosition(
      target: LatLng(
          widget.currentLocation.latitude, widget.currentLocation.longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
      bearing: 192.8334901395799,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(curr));
  }
}
