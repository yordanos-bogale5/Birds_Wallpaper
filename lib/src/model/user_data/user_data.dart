import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_data.freezed.dart';
part 'user_data.g.dart';

@unfreezed
class UserData with _$UserData {
  factory UserData({
    String? token,
    CounsellorModel? user
  }) = _UserData;

  UserData._();

  factory UserData.fromJson(Map<String, dynamic>? json) =>
      _$UserDataFromJson(json!);
}
