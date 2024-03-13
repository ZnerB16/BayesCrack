class Prediction{
  final int id;
  final String prediction;
  final int recommendID;
  final int imageID;

  Prediction({
    required this.id,
    required this.prediction,
    required this.recommendID,
    required this.imageID
  });
  factory Prediction.fromSQfliteDatabase(Map<String, dynamic> map) => Prediction(
      id: map['id']?.toInt() ?? 0,
      imageID: map['image_id']?.toInt() ?? 0,
      prediction: map['prediction'] ?? '',
      recommendID: map['recommend_id']?.toInt() ?? 0,
  );
}