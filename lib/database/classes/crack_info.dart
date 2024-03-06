class CrackInfo{
  final int id;
  final int imageID;
  final int trackingNo;
  final int buildingID;
  final int floorID;
  final int roomID;
  final String? remarks;

  CrackInfo({
    required this.id,
    required this.imageID,
    required this.trackingNo,
    required this.buildingID,
    required this.floorID,
    required this.roomID,
    this.remarks,
});
  factory CrackInfo.fromSQfliteDatabase(Map<String, dynamic> map) => CrackInfo(
    id: map['id']?.toInt() ?? 0,
    imageID: map['image_id']?.toInt() ?? 0,
    trackingNo: map['tracking_no']?.toInt() ?? 0,
    buildingID: map['building_id']?.toInt() ?? 0,
    floorID: map['floor_id']?.toInt() ?? 0,
    roomID: map['room_id']?.toInt() ?? 0,
    remarks: map['remarks'] ?? ''
  );
}