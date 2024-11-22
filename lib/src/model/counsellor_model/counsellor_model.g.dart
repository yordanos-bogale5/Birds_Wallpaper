// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counsellor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounsellorModelImpl _$$CounsellorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CounsellorModelImpl(
      id: json['_id'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      jobtitle: json['jobtitle'] as String?,
      education: json['education'] as String?,
      institution: json['institution'] as String?,
      specialization: json['specialization'] as String?,
      resetPasswordToken: json['resetPasswordToken'] as String?,
      avatarColor: json['avatarColor'] as String?,
      languagesSpeak: (json['languagesSpeak'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      helpWith: (json['helpWith'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>?))
          .toList(),
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      gender: json['gender'] as String?,
      religion: json['religion'] as String?,
      aboutMe: json['aboutMe'] as String?,
      country: json['country'] as String?,
      emailPrice: json['emailPrice'] as String?,
      videoSessionPrice: json['videoSessionPrice'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      onboard: json['onboard'] as bool?,
      disabled: json['disabled'] as bool?,
      lastActive: json['lastActive'] as String?,
      endDate: json['endDate'] as String?,
      startDate: json['startDate'] as String?,
      streamUserToken: json['streamUserToken'] as String?,
    );

Map<String, dynamic> _$$CounsellorModelImplToJson(
        _$CounsellorModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'username': instance.username,
      'avatar': instance.avatar,
      'jobtitle': instance.jobtitle,
      'education': instance.education,
      'institution': instance.institution,
      'specialization': instance.specialization,
      'resetPasswordToken': instance.resetPasswordToken,
      'avatarColor': instance.avatarColor,
      'languagesSpeak': instance.languagesSpeak,
      'helpWith': instance.helpWith,
      'experiences': instance.experiences,
      'likes': instance.likes,
      'gender': instance.gender,
      'religion': instance.religion,
      'aboutMe': instance.aboutMe,
      'country': instance.country,
      'emailPrice': instance.emailPrice,
      'videoSessionPrice': instance.videoSessionPrice,
      'likeCount': instance.likeCount,
      'isActive': instance.isActive,
      'isAdmin': instance.isAdmin,
      'onboard': instance.onboard,
      'disabled': instance.disabled,
      'lastActive': instance.lastActive,
      'endDate': instance.endDate,
      'startDate': instance.startDate,
      'streamUserToken': instance.streamUserToken,
    };
