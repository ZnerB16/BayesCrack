class Building{
  final int id;
  final String buildingName;
  Building({
    required this.id,
    required this.buildingName
  });
  factory Building.fromSQfliteDatabase(Map<String, dynamic> map) => Building(
    id: map['id']?.toInt() ?? 0,
    buildingName: map['buildingName'] ?? '',
  );
}