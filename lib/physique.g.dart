// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physique.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
