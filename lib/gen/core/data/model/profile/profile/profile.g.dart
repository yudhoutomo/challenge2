// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../core/data/model/profile/profile/profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photo': instance.photo,
    };
