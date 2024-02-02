import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation;
  bool _isLoading = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    locationData = await location.getLocation();
    setState(() {
      _isLoading = false;
    });
    log(locationData.longitude.toString());
    log(locationData.latitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No Location Choosen!",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      textAlign: TextAlign.center,
    );

    if (_isLoading) {
      previewContent = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: Text(
                "Get Current Location",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: Text(
                "Select On Map",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
