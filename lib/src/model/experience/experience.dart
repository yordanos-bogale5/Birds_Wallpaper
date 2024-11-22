import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

@unfreezed
class Experience with _$Experience {
  factory Experience({
    String? institution,
    String? specialization,
    String? startDate,
    String? endDate,
    // String? _id,
  }) = _Experience;

  Experience._();

  factory Experience.fromJson(Map<String, dynamic>? json) =>
      _$ExperienceFromJson(json!);
}
