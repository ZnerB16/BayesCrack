class ImageDB{
  int id;
  String imagePath;
  String dateTime;
  String geolocation;
  ImageDB({
    required this.id,
    required this.imagePath,
    required this.dateTime,
    required this.geolocation
  }
  );
  factory ImageDB.fromSQfliteDatabase(Map<String, dynamic> map) => ImageDB(
    id: map['id']?.toInt() ?? 0,
    imagePath: map['image_path']?? '',
    dateTime: map['capture_datetime'] ?? '',
    geolocation: map['geolocation']?? '',
  );
}
