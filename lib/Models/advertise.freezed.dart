// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'advertise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AdvertiseModel _$AdvertiseModelFromJson(Map<String, dynamic> json) {
  return _AdvertiseModel.fromJson(json);
}

/// @nodoc
mixin _$AdvertiseModel {
  int? get id => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdvertiseModelCopyWith<AdvertiseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvertiseModelCopyWith<$Res> {
  factory $AdvertiseModelCopyWith(
          AdvertiseModel value, $Res Function(AdvertiseModel) then) =
      _$AdvertiseModelCopyWithImpl<$Res>;
  $Res call({int? id, String? image, String? createdAt, String? updatedAt});
}

/// @nodoc
class _$AdvertiseModelCopyWithImpl<$Res>
    implements $AdvertiseModelCopyWith<$Res> {
  _$AdvertiseModelCopyWithImpl(this._value, this._then);

  final AdvertiseModel _value;
  // ignore: unused_field
  final $Res Function(AdvertiseModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_AdvertiseModelCopyWith<$Res>
    implements $AdvertiseModelCopyWith<$Res> {
  factory _$$_AdvertiseModelCopyWith(
          _$_AdvertiseModel value, $Res Function(_$_AdvertiseModel) then) =
      __$$_AdvertiseModelCopyWithImpl<$Res>;
  @override
  $Res call({int? id, String? image, String? createdAt, String? updatedAt});
}

/// @nodoc
class __$$_AdvertiseModelCopyWithImpl<$Res>
    extends _$AdvertiseModelCopyWithImpl<$Res>
    implements _$$_AdvertiseModelCopyWith<$Res> {
  __$$_AdvertiseModelCopyWithImpl(
      _$_AdvertiseModel _value, $Res Function(_$_AdvertiseModel) _then)
      : super(_value, (v) => _then(v as _$_AdvertiseModel));

  @override
  _$_AdvertiseModel get _value => super._value as _$_AdvertiseModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_AdvertiseModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AdvertiseModel implements _AdvertiseModel {
  const _$_AdvertiseModel(
      {this.id, this.image, this.createdAt, this.updatedAt});

  factory _$_AdvertiseModel.fromJson(Map<String, dynamic> json) =>
      _$$_AdvertiseModelFromJson(json);

  @override
  final int? id;
  @override
  final String? image;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'AdvertiseModel(id: $id, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdvertiseModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_AdvertiseModelCopyWith<_$_AdvertiseModel> get copyWith =>
      __$$_AdvertiseModelCopyWithImpl<_$_AdvertiseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdvertiseModelToJson(
      this,
    );
  }
}

abstract class _AdvertiseModel implements AdvertiseModel {
  const factory _AdvertiseModel(
      {final int? id,
      final String? image,
      final String? createdAt,
      final String? updatedAt}) = _$_AdvertiseModel;

  factory _AdvertiseModel.fromJson(Map<String, dynamic> json) =
      _$_AdvertiseModel.fromJson;

  @override
  int? get id;
  @override
  String? get image;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_AdvertiseModelCopyWith<_$_AdvertiseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
