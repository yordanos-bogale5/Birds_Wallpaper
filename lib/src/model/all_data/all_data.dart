
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_data.freezed.dart';
part 'all_data.g.dart';

@unfreezed
class AllData with _$AllData {
  factory AllData({
    List<String>? religions,
    List<String>? genders,
    List<String>? languages,
  }) = _AllData;

  AllData._();

  factory AllData.fromJson(Map<String, dynamic>? json) =>
      _$AllDataFromJson(json!);
}
