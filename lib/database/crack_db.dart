import 'package:sqflite/sqflite.dart';
import 'classes/prediction.dart';
import 'database_service.dart';
import 'classes/crack_info.dart';

class CrackDB{
  final imageTable = 'images';
  final buildingTable = 'buildings';
  final floorTable = 'floors';
  final roomTable = 'rooms';
  final crackTable = 'crack_info';
  final predictionTable = 'predictions';
  final recommendationsTable = 'recommendations';

  Future <void> createTable(Database database) async{
    // Image table
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $imageTable(
      "id" INTEGER NOT NULL,
      "image_path" TEXT NOT NULL,
      "capture_datetime" TEXT NOT NULL,
      "geolocation" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
      );
      """
    );
    // Building table
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $buildingTable(
      "id" INTEGER NOT NULL,
      "building_name" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
      );
      """
    );
    // Floor table
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $floorTable(
      "id" INTEGER NOT NULL,
      "floor_name" TEXT NOT NULL,
      "building_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("building_id") REFERENCES buildings("id")
      );
      """
    );
    // Room table
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $roomTable(
      "id" INTEGER NOT NULL,
      "room_name" TEXT NOT NULL,
      "building_id" INTEGER NOT NULL,
      "floor_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("building_id") REFERENCES buildings("id"),
      FOREIGN KEY("floor_id") REFERENCES floors("id")
      );
      """
    );

    // Crack info table
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $crackTable (
      "id" INTEGER NOT NULL,
      "image_id" INTEGER NOT NULL,
      "tracking_no" INTEGER NOT NULL,
      "building_id" INTEGER NOT NULL,
      "floor_id" INTEGER NOT NULL,
      "room_id" INTEGER NOT NULL,
      "remarks" TEXT,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("image_id") REFERENCES images("id"),
      FOREIGN KEY("building_id") REFERENCES buildings("id"),
      FOREIGN KEY("floor_id") REFERENCES floors("id"),
      FOREIGN KEY("room_id") REFERENCES rooms("id") 
      );"""
    );
    await database.execute(
      """ CREATE TABLE IF NOT EXISTS $predictionTable(
      "id" INTEGER NOT NULL,
      "prediction" TEXT NOT NULL,
      "recommendation_id" INTEGER NOT NULL,
      "image_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("recommendation_id") REFERENCES recommendations("id"),
      FOREIGN KEY("image_id") REFERENCES images("id")
      );
      """
    );
  }
  // Insert into image table
  Future<int> insertImage({required String imagePath, required String datetime, required String geolocation}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $imageTable(image_path, capture_datetime, geolocation) VALUES (?, ?, ?)
      ''',
      [imagePath, datetime, geolocation]
    );
  }
  // Insert into building table
  Future<int> insertBuilding({required String buildingName}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $buildingTable(building_name) VALUES (?)
      ''',
        [buildingName]
    );
  }
  // Insert into floor table
  Future<int> insertFloor({required String floorName}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $floorTable(floor_name) VALUES (?)
      ''',
        [floorName]
    );
  }
  // Insert into room table
  Future<int> insertRoom({required String roomName}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $floorTable(room_name) VALUES (?)
      ''',
        [roomName]
    );
  }
  // Insert into prediction table
  Future<int> insertPrediction({required String prediction, required int imageID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $predictionTable(prediction, image_id) VALUES (?, ?)
      ''',
        [prediction, imageID]
    );
  }
  // Fetch crack info
  Future<List<CrackInfo>> fetchALlCrack() async{
    final database = await DatabaseService().database;
    final crackInfo = await database.rawQuery(
      '''
      SELECT * FROM $crackTable
      CROSS JOIN image ON crack_info.image_id = image.id
      CROSS JOIN building ON crack_info.building_id = building.id
      CROSS JOIN floor ON crack_info.floor_id = floor.id
      CROSS JOIN room ON crack_info.room_id = room.id
      '''
    );
    return crackInfo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }
  // Delete image data including its info and prediction
  Future<void> deleteImage(int id) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
      '''
      DELETE FROM $imageTable WHERE id = ?;
      DELETE FROM $crackTable WHERE image_id = ?;
      DELETE FROM $predictionTable WHERE image_id = ?    
      ''', [id, id, id]
    );
  }
  // Count predictions
  Future<List> countPredictions(String prediction) async{
    final database = await DatabaseService().database;
    final count = await database.rawQuery(
      '''
      SELECT COUNT(id) 
      FROM predictions WHERE prediction = ?
      ''', [prediction]
    );
    return count.map((info) => Prediction.fromSQfliteDatabase(info)).toList();
  }
  // Count all images
  Future<List> countAll() async{
    final database = await DatabaseService().database;
    final count = await database.rawQuery(
      '''
      SELECT COUNT(id) FROM predictions
      '''
    );
    return count.map((info) => Prediction.fromSQfliteDatabase(info)).toList();
  }
}
