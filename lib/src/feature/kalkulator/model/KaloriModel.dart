import 'dart:convert';

class KaloriModel {
  String? id;
  String? result;
  
  KaloriModel({
    this.id,
    this.result,
  });

  KaloriModel copyWith({
    String? id,
    String? result,
  }) {
    return KaloriModel(
      id: id ?? this.id,
      result: result ?? this.result,
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

    return result;
  }

  factory KaloriModel.fromMap(Map<String, dynamic> map) {
    return KaloriModel(
      id: map['id'],
      result: map['result'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KaloriModel.fromJson(String source) => KaloriModel.fromMap(json.decode(source));

  @override
  String toString() => 'KaloriModel(id: $id, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KaloriModel &&
      other.id == id &&
      other.result == result;
  }

  @override
  int get hashCode => id.hashCode ^ result.hashCode;
}
