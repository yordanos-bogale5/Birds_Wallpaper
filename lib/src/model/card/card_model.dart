import 'package:freezed_annotation/freezed_annotation.dart';


part 'card_model.freezed.dart';
part 'card_model.g.dart';

@unfreezed
class CardModel with _$CardModel {
  factory CardModel({
    String? id,
    String? type,
    String? number,
    DateTime? expiry
  }) = _CardModel;

  CardModel._();

  factory CardModel.fromJson(Map<String, dynamic>? json) =>
      _$CardModelFromJson(json!);
}
