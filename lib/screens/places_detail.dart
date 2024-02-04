import 'package:flutter/material.dart';
import 'package:places/screens/map_screen.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailScreen({required this.place, super.key});

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:Z%7C$lat,$lng&key=AIzaSyDWYIwIwT2Cx7maujw2kxbcvbFKhIGhLOE";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=>  MapScreen(
                  location: place.location,
                  isSelected: false,
                ),
              ),
            );},
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        locationImage,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(49, 48, 77, 0.3),
                            Color.fromRGBO(22, 26, 48, 0.3),
                          ],
                        ),
                      ),
                      child: Text(
                        place.location.address,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
