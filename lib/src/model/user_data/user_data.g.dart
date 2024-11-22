// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : CounsellorModel.fromJson(json['user'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
