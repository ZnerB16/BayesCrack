import 'package:sqflite/sqflite.dart';
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
      """CREATE TABLE IF NOT EXISTS $imageTable(
      "id" INTEGER NOT NULL,
      "image_path" TEXT NOT NULL,
      "image_name" TEXT NOT NULL,
      "capture_datetime" TEXT NOT NULL,
      "geolocation" TEXT,
      PRIMARY KEY("id" AUTOINCREMENT)
      );
      """
    );
    // Building table
    await database.execute(
        """CREATE TABLE IF NOT EXISTS $buildingTable(
      "id" INTEGER NOT NULL,
      "building_name" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
      );
      """
    );
    // Floor table
    await database.execute(
        """CREATE TABLE IF NOT EXISTS $floorTable(
      "id" INTEGER NOT NULL,
      "floor_name" TEXT NOT NULL,
      "building_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("building_id") REFERENCES building("id")
      );
      """
    );
    // Room table
    await database.execute(
        """CREATE TABLE IF NOT EXISTS $roomTable(
      "id" INTEGER NOT NULL,
      "room_name" TEXT NOT NULL,
      "building_id" INTEGER NOT NULL,
      "floor_id" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("building_id") REFERENCES building("id"),
      FOREIGN KEY("floor_id) REFERENCES floor("id")
      );
      """
    );

    // Crack info table
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $crackTable (
      "id" INTEGER NOT NULL,
      "image_id" INTEGER NOT NULL,
      "tracking_no" INTEGER NOT NULL,
      "building_id" INTEGER NOT NULL,
      "floor_id" INTEGER NOT NULL,
      "room_id" INTEGER NOT NULL,
      "remarks" TEXT,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("image_id") REFERENCES image("id"),
      FOREIGN KEY("building_id") REFERENCES building("id"),
      FOREIGN KEY("floor_id") REFERENCES floor("id"),
      FOREIGN KEY("room_id") REFERENCES room("id") 
      );"""
    );
    await database.execute(
    """ CREATE TABLE IF NOT EXISTS $recommendationsTable(
    "id" INTEGER NOT NULL,
    "advise" TEXT NOT NULL
    );
    """);
    await database.execute(
        """ INSERT INTO $recommendationsTable ("id", "advise")
        VALUES(
          1, "There is no crack detected.
        ),
        (
          2, "This crack does not pose any serious risk. However, sealing the crack with epoxy or polyurethane-based products is recommended to prevent it from expanding. Ensure to use appropriate sealing materials suited to the type of crack and the surface material. It is also essential to monitor the growth of the crack over time."
        ),
        (
          3, "This crack poses a medium risk. As a precautionary measure, it is essential to report the crack and exercise caution in the area. Structural repairs such as injection grouting, crack stitching, or replacement of wall sections may be necessary to prevent the crack from widening. Seek assistance from a qualified professional to assess the extent of the damage and ensure appropriate repair methods."
        ),
        (
          4, "All occupants should evacuate the building immediately and report the crack. Large cracks indicate severe structural instability, posing high risks to anyone inside. Extensive repair works such as structural reinforcement, wall replacements, breaking out, or recasting may be required to ensure the building's safety. A qualified professional will assess the extent of the damage and ensure appropriate repair methods."
        );   
    """);
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
  Future<int> createImage({required String imagePath}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''
      INSERT INTO $imageTable(image_path) VALUES (?)
      ''',
      [imagePath]
    );
  }
  Future<int> createBuilding({required String buildingName}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''
      INSERT INTO $buildingTable(building_name) VALUES (?)
      ''',
        [buildingName]
    );
  }
  Future<int> createFloor({required String floorName, required int buildingID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''
      INSERT INTO $floorTable(floor_name, building_id) VALUES (?, ?)
      ''',
        [floorName, buildingID]
    );
  }
  Future<int> createRoom({required String roomName, required int buildingID, required int floorID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''
      INSERT INTO $floorTable(room_name, building_id, floor_id) VALUES (?, ?, ?)
      ''',
        [roomName, buildingID, floorID]
    );
  }
  Future<int> createPrediction({required String prediction, required int recommendID, required int imageID}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert(
        '''
      INSERT INTO $predictionTable(prediction, recommendation_id, image_id) VALUES (?, ?, ?)
      ''',
        [prediction, recommendID, imageID]
    );
  }
  Future<List<CrackInfo>> fetchALlCrack() async{
    final database = await DatabaseService().database;
    final crackInfo = await database.rawQuery(
      '''
      SELECT * FROM crack_info
      JOIN image ON crack_info.image_id = image.id
      JOIN building ON crack_info.building_id = building.id
      JOIN floor ON crack_info.floor_id = floor.id
      JOIN room ON crack_info.room_id = room.id
      '''
    );
    return crackInfo.map((info) => CrackInfo.fromSQfliteDatabase(info)).toList();
  }
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
}