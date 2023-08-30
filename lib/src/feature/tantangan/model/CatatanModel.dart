import 'dart:convert';

class CatatanModel {
  String? id;
  String? catatan;

  CatatanModel({
    this.id,
    this.catatan,
  });

  CatatanModel copyWith({
    String? id,
    String? catatan,
  }) {
    return CatatanModel(
      id: id ?? this.id,
      catatan: catatan ?? this.catatan,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (catatan != null) {
      result.addAll({'catatan': catatan});
    }

    return result;
  }

  factory CatatanModel.fromMap(Map<String, dynamic> map) {
    return CatatanModel(
      id: map['id'],
      catatan: map['catatan'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CatatanModel.fromJson(String source) =>
      CatatanModel.fromMap(json.decode(source));

  @override
  String toString() => 'CatatanModel(id: $id, catatan: $catatan)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CatatanModel && other.id == id && other.catatan == catatan;
  }

  @override
  int get hashCode => id.hashCode ^ catatan.hashCode;
}
