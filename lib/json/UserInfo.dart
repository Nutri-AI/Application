import 'RDI.dart';
import 'physique.dart';

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      pk: json['PK'] as String,
      sk: json['SK'] as String,
      username: json['username'] as String,
      physique: Physique.fromJson(json['physique'] as Map<String, dynamic>),
      rdi: RDI.fromJson(json['RDI'] as Map<String, dynamic>),
      nutrSuppl: json['nutr_suppl'] as List<dynamic>,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'PK': instance.pk,
      'SK': instance.sk,
      'username': instance.username,
      'physique': instance.physique.toJson(),
      'RDI': instance.rdi.toJson(),
      'nutr_suppl': instance.nutrSuppl.toList(),
    };

class UserInfo {
  final String pk;
  final String sk;
  final String username;
  Physique physique;
  RDI rdi;
  List<dynamic> nutrSuppl;

  UserInfo({
    required this.username,
    required this.physique,
    required this.rdi,
    required this.pk,
    required this.sk,
    required this.nutrSuppl,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
