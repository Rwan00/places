import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelected;
  const MapScreen(
      {this.location = const PlaceLocation(
          address: "", latitude: 40.711614, longitude: -74.012318),
          this.isSelected = true,
      super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelected? "Pick Your Location":"Your Location"),
        actions: [
          if(widget.isSelected)
          IconButton(onPressed: (){}, icon: const Icon(Icons.save),),
        ],
      ),
      body:GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("x1"),
            position: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          )
        },
      ),
    );
  }
}
