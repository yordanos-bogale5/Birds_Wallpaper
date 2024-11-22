// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllData _$AllDataFromJson(Map<String, dynamic> json) {
  return _AllData.fromJson(json);
}

/// @nodoc
mixin _$AllData {
  List<String>? get religions => throw _privateConstructorUsedError;
  set religions(List<String>? value) => throw _privateConstructorUsedError;
  List<String>? get genders => throw _privateConstructorUsedError;
  set genders(List<String>? value) => throw _privateConstructorUsedError;
  List<String>? get languages => throw _privateConstructorUsedError;
  set languages(List<String>? value) => throw _privateConstructorUsedError;

  /// Serializes this AllData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllDataCopyWith<AllData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllDataCopyWith<$Res> {
  factory $AllDataCopyWith(AllData value, $Res Function(AllData) then) =
      _$AllDataCopyWithImpl<$Res, AllData>;
  @useResult
  $Res call(
      {List<String>? religions,
      List<String>? genders,
      List<String>? languages});
}

/// @nodoc
class _$AllDataCopyWithImpl<$Res, $Val extends AllData>
    implements $AllDataCopyWith<$Res> {
  _$AllDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? religions = freezed,
    Object? genders = freezed,
    Object? languages = freezed,
  }) {
    return _then(_value.copyWith(
      religions: freezed == religions
          ? _value.religions
          : religions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      genders: freezed == genders
          ? _value.genders
          : genders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      languages: freezed == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllDataImplCopyWith<$Res> implements $AllDataCopyWith<$Res> {
  factory _$$AllDataImplCopyWith(
          _$AllDataImpl value, $Res Function(_$AllDataImpl) then) =
      __$$AllDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? religions,
      List<String>? genders,
      List<String>? languages});
}

/// @nodoc
class __$$AllDataImplCopyWithImpl<$Res>
    extends _$AllDataCopyWithImpl<$Res, _$AllDataImpl>
    implements _$$AllDataImplCopyWith<$Res> {
  __$$AllDataImplCopyWithImpl(
      _$AllDataImpl _value, $Res Function(_$AllDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? religions = freezed,
    Object? genders = freezed,
    Object? languages = freezed,
  }) {
    return _then(_$AllDataImpl(
      religions: freezed == religions
          ? _value.religions
          : religions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      genders: freezed == genders
          ? _value.genders
          : genders // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      languages: freezed == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllDataImpl extends _AllData {
  _$AllDataImpl({this.religions, this.genders, this.languages}) : super._();

  factory _$AllDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllDataImplFromJson(json);

  @override
  List<String>? religions;
  @override
  List<String>? genders;
  @override
  List<String>? languages;

  @override
  String toString() {
    return 'AllData(religions: $religions, genders: $genders, languages: $languages)';
  }

  /// Create a copy of AllData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllDataImplCopyWith<_$AllDataImpl> get copyWith =>
      __$$AllDataImplCopyWithImpl<_$AllDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllDataImplToJson(
      this,
    );
  }
}

abstract class _AllData extends AllData {
  factory _AllData(
      {List<String>? religions,
      List<String>? genders,
      List<String>? languages}) = _$AllDataImpl;
  _AllData._() : super._();

  factory _AllData.fromJson(Map<String, dynamic> json) = _$AllDataImpl.fromJson;

  @override
  List<String>? get religions;
  set religions(List<String>? value);
  @override
  List<String>? get genders;
  set genders(List<String>? value);
  @override
  List<String>? get languages;
  set languages(List<String>? value);

  /// Create a copy of AllData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllDataImplCopyWith<_$AllDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
