class EdukasiModel{
  final String id;
  final String link;
  final String kategori;
  final String title;

  EdukasiModel({
    required this.id,
    required this.link,
    required this.kategori,
    required this.title
  });

  factory EdukasiModel.fromJson(String key, Map<String, dynamic> json) {
    return EdukasiModel(
      id: key,
      link: json['link'],
      kategori: json['kategori'],
      title: json['title'],
    );
  }
}