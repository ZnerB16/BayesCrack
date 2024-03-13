class Floor{
  final int id;
  final String floorName;
  final int buildingID;
  Floor({
    required this.id,
    required this.floorName,
    required this.buildingID
  });
  factory Floor.fromSQfliteDatabase(Map<String, dynamic> map) => Floor(
    id: map['id']?.toInt() ?? 0,
    floorName: map['floorName'] ?? '',
    buildingID: map['buildingID']?.toInt() ?? 0,
  );
}