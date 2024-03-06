class Image{
  final int id;
  final String imagePath;
  final String imageName;
  final String dateTime;
  final String? geolocation;
  Image({
    required this.id,
    required this.imagePath,
    required this.imageName,
    required this.dateTime,
    this.geolocation
  });

}
