/////////////// User Physique JSON //////////////////

// import 'package:json_annotation/json_annotation.dart';

Physique _$PhysiqueFromJson(Map<String, dynamic> json) => Physique(
      birth: json['birth'] as String,
      sex: json['sex'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      PAI: json['PAI'] as double,
    );

Map<String, dynamic> _$PhysiqueToJson(Physique instance) => <String, dynamic>{
      'birth': instance.birth,
      'sex': instance.sex,
      'height': instance.height,
      'weight': instance.weight,
      'PAI': instance.PAI,
    };

// @JsonSerializable()
class Physique {
  final String birth;
  final String sex;
  final int height;
  final int weight;
  final double PAI;

  Physique(
      {required this.birth,
      required this.sex,
      required this.height,
      required this.weight,
      required this.PAI});

  factory Physique.fromJson(Map<String, dynamic> json) =>
      _$PhysiqueFromJson(json);
  Map<String, dynamic> toJson() => _$PhysiqueToJson(this);
}
