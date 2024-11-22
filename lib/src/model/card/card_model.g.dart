// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardModelImpl _$$CardModelImplFromJson(Map<String, dynamic> json) =>
    _$CardModelImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      number: json['number'] as String?,
      expiry: json['expiry'] == null
          ? null
          : DateTime.parse(json['expiry'] as String),
    );

Map<String, dynamic> _$$CardModelImplToJson(_$CardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'number': instance.number,
      'expiry': instance.expiry?.toIso8601String(),
    };
