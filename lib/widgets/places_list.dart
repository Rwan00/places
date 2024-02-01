import 'package:flutter/material.dart';
import 'package:places/screens/places_detail.dart';

import '../models/place.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;

  const PlacesList({required this.places, super.key});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No Places Added Yet!",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=>  PlaceDetailScreen(place: places[index]),
              ),
            );
          },
        );
      },
    );
  }
}
