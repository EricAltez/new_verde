import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {

  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController? mapController;

  var isLight = true;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
          styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,
          accessToken: const String.fromEnvironment("pk.eyJ1IjoibWFyY29zb3oiLCJhIjoiY2w0bjgwdHF6MGM5NDNicG9xNXpqdjA3ZyJ9.nEpP8t_s35vohx-KVzlKgQ"),
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(target: LatLng(-34.79118920401331, -56.07099583821499)),
          onStyleLoadedCallback: _onStyleLoadedCallback,
        )
    );
  }
}
