class Recommendation{
  final int id;
  final String advise;

  Recommendation({
    required this.id,
    required this.advise
  });
  factory Recommendation.fromSQfliteDatabase(Map<String, dynamic> map) => Recommendation(
      id: map['id']?.toInt() ?? 0,
      advise: map['advise'] ?? ''
  );
}