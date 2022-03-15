// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Input_UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userid: json['userid'] as String,
      username: json['username'] as String,
      physique: Physique.fromJson(json['physique'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userid': instance.userid,
      'username': instance.username,
      'physique': instance.physique.toJson(),
    };
