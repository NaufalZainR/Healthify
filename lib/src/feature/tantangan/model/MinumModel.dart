import 'dart:convert';

class MinumModel {
  String? id;
  int? minumMl;
  String? time;
  
  MinumModel({
    this.id,
    this.minumMl,
    this.time,
  });

  MinumModel copyWith({
    String? id,
    int? minumMl,
    String? time,
  }) {
    return MinumModel(
      id: id ?? this.id,
      minumMl: minumMl ?? this.minumMl,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if(id != null){
      result.addAll({'id': id});
    }
    if(minumMl != null){
      result.addAll({'minumMl': minumMl});
    }
    if(time != null){
      result.addAll({'time': time});
    }

    return result;
  }

  factory MinumModel.fromMap(Map<String, dynamic> map) {
    return MinumModel(
      id: map['id'],
      minumMl: map['minumMl']?.toInt(),
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MinumModel.fromJson(String source) => MinumModel.fromMap(json.decode(source));

  @override
  String toString() => 'MinumModel(id: $id, minumMl: $minumMl, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MinumModel &&
      other.id == id &&
      other.minumMl == minumMl &&
      other.time == time;
  }

  @override
  int get hashCode => id.hashCode ^ minumMl.hashCode ^ time.hashCode;
}
