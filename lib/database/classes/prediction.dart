class Prediction{
  final String prediction;
  final String recommend;
  final int imageID;

  Prediction({
    required this.prediction,
    required this.recommend,
    required this.imageID
  });
  factory Prediction.fromSQfliteDatabase(Map<String, dynamic> map) => Prediction(
      prediction: map['prediction'] ?? '',
      recommend: map['recommendation'],
      imageID: map['image_id']?.toInt() ?? 0,
  );
}