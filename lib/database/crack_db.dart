
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
  Future<List<Prediction>> getPrediction({required int imageID}) async{
    final database = await DatabaseService().database;
    final predictionInfo = await database.rawQuery(
      '''
      SELECT prediction, recommendation 
      FROM $predictionTable
      WHERE image_id = ?
      ''',
        [imageID]
    );
    return predictionInfo.map((info) => Prediction.fromSQfliteDatabase(info)).toList();
}
  // Fetch crack info
  Future<List<CrackInfo>> fetchALlCrack({required int imageID}) async{
    final database = await DatabaseService().database;
    final crackInfo = await database.rawQuery(
      '''
      SELECT * FROM $crackTable
      CROSS JOIN $imageTable ON crack_info.image_id = $imageTable.id
      CROSS JOIN $buildingTable ON crack_info.building_id = $buildingTable.id
      CROSS JOIN $floorTable ON crack_info.floor_id = $floorTable.id
      CROSS JOIN $roomTable ON crack_info.room_id = $roomTable.id
      WHERE $crackTable.image_id = ?
      ''', [imageID]
    );
    return crackInfo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }
  // Fetch crack info IDs
  Future<List<CrackInfo>> fetchALlCrackIDs({required int imageID}) async{
    final database = await DatabaseService().database;
    final crackInfo = await database.rawQuery(
        '''
      SELECT * FROM $crackTable
      WHERE image_id = ?
      ''', [imageID]
    );
    return crackInfo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }
  // Fetch crack info IDs
  Future<List<CrackInfo>> fetchALlCrackTracking({required int trackingNo}) async{
    final database = await DatabaseService().database;
    final crackInfo = await database.rawQuery(
        '''
      SELECT * FROM $crackTable
      WHERE tracking_no = ?
      ''', [trackingNo]
    );
    return crackInfo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
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
  Future<List<Building>> getLatestBuilding() async{
    final database = await DatabaseService().database;
    final building = await database.rawQuery(
      '''
      SELECT id FROM $buildingTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return building.map((info) => Building.fromSQfliteDatabase(info)).toList();
  }
  Future<List<Floor>> getLatestFloor() async{
    final database = await DatabaseService().database;
    final floor = await database.rawQuery(
      '''
      SELECT id FROM $floorTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return floor.map((info) => Floor.fromSQfliteDatabase(info)).toList();
  }
  Future<List<Room>> getLatestRoom() async{
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

  Future<List<ImageDB>> getLatestImageID() async{
    final database = await DatabaseService().database;
    var images = await database.rawQuery(
        '''
      SELECT id FROM $imageTable ORDER BY id DESC LIMIT 1;
      '''
    );
    return images.map((info) => ImageDB.fromSQfliteDatabase(info)).toList();
  }

  Future<List<CrackInfo>> getTrackingNo({required int imageID}) async{
    final database = await DatabaseService().database;
    var trackingNo = await database.rawQuery(
        '''
      SELECT tracking_no 
      FROM $crackTable
      WHERE image_id = ?;
      ''', [imageID]
    );
    return trackingNo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }

  Future<List<ImageDB>> getImageOnTrackingNo({required int trackingNo}) async{
    final database = await DatabaseService().database;
    var images = await database.rawQuery(
        '''
      SELECT id, image_path, capture_datetime FROM $imageTable 
      WHERE id IN 
        (SELECT image_id FROM $crackTable WHERE tracking_no = ?)
      ORDER BY capture_datetime DESC;
      ''', [trackingNo]
    );
    return images.map((info) => ImageDB.fromSQfliteDatabase(info)).toList();
  }
  Future<List<ImageDB>> getImageID({required int imageID}) async{
    final database = await DatabaseService().database;
    var images = await database.rawQuery(
        '''
      SELECT id, image_path, capture_datetime FROM $imageTable WHERE id = ? ;
      ''', [imageID]
    );
    return images.map((info) => ImageDB.fromSQfliteDatabase(info)).toList();
  }

  Future<List<ImageDB>> getFiveLatestImages() async{
    final database = await DatabaseService().database;
    final images = await database.rawQuery(
      '''
      SELECT * FROM $imageTable ORDER BY id DESC LIMIT 5;
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
      SELECT DISTINCT tracking_no FROM $crackTable ORDER BY tracking_no ASC;
      '''
    );
    return trackingNo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }
  // Delete image data
  Future<void> deleteImage({required int id}) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
      '''
      DELETE FROM $imageTable WHERE id = ?;
      ''', [id]
    );
  }
  // Delete building data
  Future<void> deleteBuilding({required int id}) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
        '''
      DELETE FROM $buildingTable WHERE id = ?;
      ''', [id]
    );
  }
  // Delete floor data
  Future<void> deleteFloor({required int id}) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
        '''
      DELETE FROM $floorTable WHERE id = ?;
      ''', [id]
    );
  }
  // Delete floor data
  Future<void> deleteRoom({required int id}) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
        '''
      DELETE FROM $roomTable WHERE id = ?;
      ''', [id]
    );
  }
  // Delete floor data
  Future<void> deletePrediction({required int id}) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
        '''
      DELETE FROM $predictionTable WHERE image_id = ?;
      ''', [id]
    );
  }
  // Delete floor data
  Future<void> deleteCrackInfo({required int id}) async{
    final database = await DatabaseService().database;
    await database.rawDelete(
        '''
      DELETE FROM $crackTable WHERE image_id = ?;
      ''', [id]
    );
  }
}
