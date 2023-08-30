import 'dart:convert';

class LencanaModel {
  final String id;
  final List<String> idListTugas;
  final String titleText;
  final String deskripsi;
  final String photoPath;

  LencanaModel({
    required this.id,
    required this.idListTugas,
    required this.titleText,
    required this.deskripsi,
    required this.photoPath,
  });

  factory LencanaModel.fromJson(String key, Map<String, dynamic> json) {
    return LencanaModel(
      id: key,
      idListTugas: List<String>.from(json['id_list_tugas']),
      titleText: json['title_text'],
      deskripsi: json['deskripsi'],
      photoPath: json['photo_path'],
    );
  }
}
