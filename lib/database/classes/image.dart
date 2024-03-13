class Image{
  final int id;
  final String imagePath;
  final String dateTime;
  final String? geolocation;
  Image({
    required this.id,
    required this.imagePath,
    required this.dateTime,
    this.geolocation
  });
  factory Image.fromSQfliteDatabase(Map<String, dynamic> map) => Image(
    id: map['id']?.toInt() ?? 0,
    imagePath: map['image_id'] ?? '',
    dateTime: map['capture_datetime'] ?? '',
    geolocation: map['geolocation'] ?? '',
  );

}
