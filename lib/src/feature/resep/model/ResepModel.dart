
class ResepModel {
  final String id;
  final String kategori;
  final String title;
  final String subtitle;
  final String resepText;
  final String tutorialText;
  final String photoPath;

  ResepModel({
    required this.id,
    required this.kategori,
    required this.title,
    required this.subtitle,
    required this.resepText,
    required this.tutorialText,
    required this.photoPath,
  });

  factory ResepModel.fromJson(String key, Map<String, dynamic> json) {
    return ResepModel(
      id: key,
      kategori: json['kategori'],
      title: json['title'],
      subtitle: json['sub_title'],
      resepText: json['resep_text'],
      tutorialText: json['tutorial_text'],
      photoPath: json['photo_path'],
    );
  }
}
