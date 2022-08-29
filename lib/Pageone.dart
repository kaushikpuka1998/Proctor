import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Set<Marker> _allMarkers = {};
  late BitmapDescriptor mapMarker;
  Uint8List? markerIMage;

  @override
  void initState() {
    // TODO: implement initState
    setCustomMarker();
    super.initState();
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData byteData = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setCustomMarker() async {
    markerIMage = await getBytesFromAssets("images/red_marker.png", 100);
  }

  void abc() async {}

  void _onMarkercreated(GoogleMapController googleMapController) {
    setState(() {
      _allMarkers.add(Marker(
          markerId: MarkerId("id-1"),
          position: LatLng(22.5448131, 88.3403691),
          icon: BitmapDescriptor.fromBytes(markerIMage!),
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
