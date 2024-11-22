import 'package:chatremedy/src/model/experience/experience.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counsellor_model.freezed.dart';
part 'counsellor_model.g.dart';

@unfreezed
class CounsellorModel with _$CounsellorModel {
  factory CounsellorModel({
    @JsonKey(name: '_id') String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? username,
    String? avatar,
    String? jobtitle,
    String? education,
    String? institution,
    String? specialization,
    String? resetPasswordToken,
    String? avatarColor,
    List<String>? languagesSpeak,
    List<String>? helpWith,
    List<Experience>? experiences,
    List<String>? likes,
    String? gender,
    String? religion,
    String? aboutMe,
    String? country,
    String? emailPrice,
    String? videoSessionPrice,
    int? likeCount,
    bool? isActive,
    bool? isAdmin,
    bool? onboard,
    bool? disabled,
    String? lastActive,
    String? endDate,
    String? startDate,
    String? streamUserToken,
  }) = _CounsellorModel;

  CounsellorModel._();

  factory CounsellorModel.fromJson(Map<String, dynamic>? json) =>
      _$CounsellorModelFromJson(json!);
}
