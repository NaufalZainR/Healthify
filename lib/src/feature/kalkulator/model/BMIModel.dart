import 'dart:convert';

class BMIModel {
  String? id;
  double? result;
  String? keterangan;
  
  BMIModel({
    this.id,
    this.result,
    this.keterangan,
  });

  BMIModel copyWith({
    String? id,
    double? result,
    String? keterangan,
  }) {
    return BMIModel(
      id: id ?? this.id,
      result: result ?? this.result,
      keterangan: keterangan ?? this.keterangan,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if(id != null){
      result.addAll({'id': id});
    }
    if(result != null){
      result.addAll({'result': result});
    }
    if(keterangan != null){
      result.addAll({'keterangan': keterangan});
    }

    return result;
  }

  factory BMIModel.fromMap(Map<String, dynamic> map) {
    return BMIModel(
      id: map['id'],
      result: map['result']?.toDouble(),
      keterangan: map['keterangan'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BMIModel.fromJson(String source) => BMIModel.fromMap(json.decode(source));

  @override
  String toString() => 'BMIModel(id: $id, result: $result, keterangan: $keterangan)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BMIModel &&
      other.id == id &&
      other.result == result &&
      other.keterangan == keterangan;
  }

  @override
  int get hashCode => id.hashCode ^ result.hashCode ^ keterangan.hashCode;
}
