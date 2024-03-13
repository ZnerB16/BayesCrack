class Room{
  final int id;
  final String roomName;
  final int buildingID;
  final int floorID;
  Room({
    required this.id,
    required this.roomName,
    required this.buildingID,
    required this.floorID
  });
  factory Room.fromSQfliteDatabase(Map<String, dynamic> map) => Room(
    id: map['id']?.toInt() ?? 0,
    roomName: map['floor_name'] ?? '',
    buildingID: map['building_id']?.toInt() ?? 0,
    floorID: map['floor_id']?.toInt() ?? 0,
  );
}