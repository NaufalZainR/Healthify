
class RankModel {
  final String id;
  final String username;
  final int score;
  final String photoPath;

  RankModel({
    required this.id,
    required this.username,
    required this.score,
    required this.photoPath,
  });

  factory RankModel.fromJson(String key, Map<String, dynamic> json) {
    return RankModel(
      id: key,
      username: json['username'] ?? '',
      score: json['score'] ?? 0,
      photoPath: json['photo'] ?? '',
    );
  }
}
