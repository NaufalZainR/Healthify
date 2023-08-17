import 'dart:convert';

class TugasModel {
  String? id;
  String? titleText;
  int? score;
  String? deskripsi;
  String? photoPath;
  
  TugasModel({
    this.id,
    this.titleText,
    this.score,
    this.deskripsi,
    this.photoPath,
  });

  TugasModel copyWith({
    String? id,
    String? titleText,
    int? score,
    String? deskripsi,
    String? photoPath,
  }) {
    return TugasModel(
      id: id ?? this.id,
      titleText: titleText ?? this.titleText,
      score: score ?? this.score,
      deskripsi: deskripsi ?? this.deskripsi,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if(id != null){
      result.addAll({'id': id});
    }
    if(titleText != null){
      result.addAll({'titleText': titleText});
    }
    if(score != null){
      result.addAll({'score': score});
    }
    if(deskripsi != null){
      result.addAll({'deskripsi': deskripsi});
    }
    if(photoPath != null){
      result.addAll({'photoPath': photoPath});
    }

    return result;
  }

  factory TugasModel.fromMap(Map<String, dynamic> map) {
    return TugasModel(
      id: map['id'],
      titleText: map['titleText'],
      score: map['score']?.toInt(),
      deskripsi: map['deskripsi'],
      photoPath: map['photoPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TugasModel.fromJson(String source) => TugasModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TugasModel(id: $id, titleText: $titleText, score: $score, deskripsi: $deskripsi, photoPath: $photoPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TugasModel &&
      other.id == id &&
      other.titleText == titleText &&
      other.score == score &&
      other.deskripsi == deskripsi &&
      other.photoPath == photoPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      titleText.hashCode ^
      score.hashCode ^
      deskripsi.hashCode ^
      photoPath.hashCode;
  }
}
