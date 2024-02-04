import 'dart:io';
import 'dart:developer';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import '../models/place.dart';

Future<sql.Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, "place.db"),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,address TEXT)");
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void loadPlaces() async {
    final sql.Database db = await _getDatabase();
    final data = await db.query("user_places");

    final places = data
        .map(
          (row) => Place(
            id: row["id"] as String,
            title: row["title"] as String,
            image: File(row["image"] as String),
            location: PlaceLocation(
                latitude: row["lat"] as double,
                longitude: row["lng"] as double,
                address: row["address"] as String),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImg = await image.copy("${appDir.path}/$fileName");
    log(copiedImg.path);
    final newPlace = Place(title: title, image: image, location: location);

    final db = await _getDatabase();

    db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image,
      "lat": newPlace.location.latitude,
      "lng": newPlace.location.longitude,
      "address": newPlace.location.address,
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
