import 'dart:ui';

import 'package:mobile_app/globals.dart';
import 'package:sqflite/sqflite.dart';
import 'classes/image.dart';
import 'classes/building.dart';
import 'classes/floor.dart';
import 'classes/prediction.dart';
import 'classes/room.dart';
import 'database_service.dart';
import 'classes/crack_info.dart';

class CrackDB{
  final imageTable = 'images';
  final buildingTable = 'buildings';
  final floorTable = 'floors';
  final roomTable = 'rooms';
  final crackTable = 'crack_info';
  final predictionTable = 'predictions';

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
      "recommendation" TEXT NOT NULL,
      "image_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT), 
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
  Future<int> insertFloor({required String floorName, required int buildingID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $floorTable(floor_name, building_id) VALUES (?, ?)
      ''',
        [floorName, buildingID]
    );
  }
  // Insert into room table
  Future<int> insertRoom({required String roomName, required int buildingID, required int floorID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $roomTable(room_name, building_id, floor_id) VALUES (?, ?, ?)
      ''',
        [roomName, buildingID, floorID]
    );
  }
  // Insert into crack table
  Future<int> insertCrackInfo({required int imageID, required int trackingNo, required int buildingID, required int floorID, required int roomID, required String remarks}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''
      INSERT INTO $crackTable(image_id, tracking_no, building_id, floor_id, room_id, remarks) 
      VALUES (?, ?, ?, ?, ?, ?)
      ''',
        [imageID, trackingNo, buildingID, floorID, roomID, remarks]
    );
  }

  // Insert into prediction table
  Future<int> insertPrediction({required String prediction, required String recommendation, required int imageID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $predictionTable(prediction, recommendation, image_id) VALUES (?, ?, ?)
      ''',
        [prediction, recommendation, imageID]
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
  Future<int?> countPredictions(String prediction) async{
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> count = await database.rawQuery(
      '''
      SELECT COUNT(id) 
      FROM $predictionTable WHERE prediction = ?
      ''', [prediction]
    );
    int? result = Sqflite.firstIntValue(count);
    return result;
  }
  // Count all images
  Future<int?> countAll() async{
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> count = await database.rawQuery(
      '''
      SELECT COUNT(*) FROM $predictionTable
      '''
    );
    int? result = Sqflite.firstIntValue(count);
    return result;
  }
  Future<List> getLatestBuilding() async{
    final database = await DatabaseService().database;
    final building = await database.rawQuery(
      '''
      SELECT id FROM $buildingTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return building.map((info) => Building.fromSQfliteDatabase(info)).toList();
  }
  Future<List> getLatestFloor() async{
    final database = await DatabaseService().database;
    final floor = await database.rawQuery(
      '''
      SELECT id FROM $floorTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return floor.map((info) => Floor.fromSQfliteDatabase(info)).toList();
  }
  Future<List> getLatestRoom() async{
    final database = await DatabaseService().database;
    final room = await database.rawQuery(
      '''
      SELECT id FROM $roomTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return room.map((info) => Room.fromSQfliteDatabase(info)).toList();
  }
  Future<List<ImageDB>> getLatestImage() async{
    final database = await DatabaseService().database;
    var images = await database.rawQuery(
      '''
      SELECT image_path FROM $imageTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return images.map((info) => ImageDB.fromSQfliteDatabase(info)).toList();
  }
  Future<List<ImageDB>> getImageOnTrackingNo({required int trackingNo}) async{
    final database = await DatabaseService().database;
    var images = await database.rawQuery(
        '''
      SELECT id, image_path, capture_datetime FROM $imageTable WHERE id IN (SELECT image_id FROM $crackTable WHERE tracking_no = ?) ;
      ''', [trackingNo]
    );
    return images.map((info) => ImageDB.fromSQfliteDatabase(info)).toList();
  }

  Future<List> getSixLatestImages() async{
    final database = await DatabaseService().database;
    final images = await database.rawQuery(
      '''
      SELECT * FROM $imageTable ORDER BY id DESC LIMIT 6;
      '''
    );
    return images.map((info) => ImageDB.fromSQfliteDatabase(info)).toList();
  }

  Future<int?> getTrackingNoCount() async{
    final database = await DatabaseService().database;
    List<Map<String, dynamic>> count = await database.rawQuery(
        '''
      SELECT COUNT(*) FROM $crackTable
      '''
    );
    int? result = Sqflite.firstIntValue(count);
    return result;
  }

  Future<List<CrackInfo>> getTrackingNos() async{
    final database = await DatabaseService().database;
    final trackingNo = await database.rawQuery(
        '''
      SELECT DISTINCT tracking_no FROM $crackTable;
      '''
    );
    return trackingNo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }
}
