// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllDataImpl _$$AllDataImplFromJson(Map<String, dynamic> json) =>
    _$AllDataImpl(
      religions: (json['religions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genders:
          (json['genders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$AllDataImplToJson(_$AllDataImpl instance) =>
    <String, dynamic>{
      'religions': instance.religions,
      'genders': instance.genders,
      'languages': instance.languages,
    };
