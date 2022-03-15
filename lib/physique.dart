import 'package:json_annotation/json_annotation.dart';
part 'physique.g.dart';

@JsonSerializable()
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
