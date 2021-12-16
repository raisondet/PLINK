import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  State<GoogleMapWidget> createState() => GoogleMapState();
}

class GoogleMapState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Position? position;

  void getLocation() async {
    Position pos =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    setState(() {
      position = pos;
      print(position);
      // TODO : CHECK Current location
    });
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/style/map_style.json');
    controller.setMapStyle(value);
  }
  Set<Marker> _createMarker(){
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: position == null
              ? LatLng(37.2785209,127.0735166)
              : LatLng(position?.latitude, position?.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Current Location')
      )
    ].toSet();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.2785209,127.0735166),
    zoom: 16.4,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _createMarker(),
        initialCameraPosition: CameraPosition(
          target: position == null
              ? LatLng(37.2785209,127.0735166)
              : LatLng(position?.latitude, position?.longitude),
          zoom: 16.4,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _setStyle(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
