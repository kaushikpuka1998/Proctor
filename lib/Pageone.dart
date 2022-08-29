import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Set<Marker> _allMarkers = {};
  void _onMarkercreated(GoogleMapController googleMapController) {
    setState(() {
      _allMarkers.add(Marker(
          markerId: MarkerId("id-1"),
          position: LatLng(22.5448131, 88.3403691),
          infoWindow: InfoWindow(title: 'Your Location', snippet: 'Position')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shortest Route'),
          centerTitle: true,
        ),
        body: GoogleMap(
            onMapCreated: _onMarkercreated,
            markers: _allMarkers,
            initialCameraPosition: CameraPosition(
                target: LatLng(22.5448131, 88.3403691), zoom: 16)));
  }
}
