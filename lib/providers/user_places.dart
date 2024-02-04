import 'dart:io';
import 'dart:developer';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import '../models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImg = await image.copy("${appDir.path}/$fileName");
    log(copiedImg.path);
    final newPlace = Place(title: title, image: image, location: location);
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, "place.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,address TEXT)");
      },
      version: 1,
    );
    db.insert("user_places", {
      "id" : newPlace.id,
      "title": newPlace.title,
      "image" : newPlace.image,
      "lat" : newPlace.location.latitude,
      "lng" : newPlace.location.longitude,
      "address" : newPlace.location.address,
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
