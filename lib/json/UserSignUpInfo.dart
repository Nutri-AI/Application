/////////////// UserSignUpInfo INFO JSON //////////////////
// import 'package:json_annotation/json_annotation.dart';
import 'physique.dart';

UserSignUpInfo _$UserSignUpInfoFromJson(Map<String, dynamic> json) =>
    UserSignUpInfo(
      userid: json['userid'] as String,
      username: json['username'] as String,
      physique: Physique.fromJson(json['physique'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSignUpInfoToJson(UserSignUpInfo instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'username': instance.username,
      'physique': instance.physique.toJson(),
    };

// @JsonSerializable(explicitToJson: true)
class UserSignUpInfo {
  final String userid;
  final String username;
  Physique physique;

  UserSignUpInfo(
      {required this.userid, required this.username, required this.physique});

  factory UserSignUpInfo.fromJson(Map<String, dynamic> json) =>
      _$UserSignUpInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserSignUpInfoToJson(this);
}
