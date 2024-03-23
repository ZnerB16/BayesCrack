class CrackInfo{
  final int id;
  final int trackingNo;
  final int imageID;
  final int buildingID;
  final String building;
  final int floorID;
  final String floor;
  final int roomID;
  final String room;
  final String? remarks;
  final String imagePath;
  final String date;
  final String geolocation;


  CrackInfo({
    required this.id,
    required this.trackingNo,
    required this.imageID,
    required this.buildingID,
    required this.building,
    required this.floorID,
    required this.floor,
    required this.roomID,
    required this.room,
    this.remarks,
    required this.imagePath,
    required this.date,
    required this.geolocation
});
  factory CrackInfo.fromSQfliteDatabase(Map<String, dynamic> map) => CrackInfo(
    id: map['id']?.toInt() ?? 0,
    trackingNo: map['tracking_no']?.toInt() ?? 0,
    imageID: map['image_id']?.toInt() ?? 0,
    buildingID: map['building_id']?.toInt() ?? 0,
    floorID: map['floor_id']?.toInt() ?? 0,
    roomID: map['room_id']?.toInt() ?? 0,
    remarks: map['remarks'] ?? '',
    imagePath: map['image_path'] ?? '',
    date: map['date'] ?? '',
    geolocation: map['geolocation'] ?? '',
    building: map['building_name'] ?? '',
    floor: map['floor_name'] ?? '',
    room: map['room_name'] ?? '',
  );
}