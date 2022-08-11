// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  num? get price => throw _privateConstructorUsedError;
  num? get rating => throw _privateConstructorUsedError;
  Map<String, dynamic>? get images => throw _privateConstructorUsedError;
  int? get cid => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? title,
      String? details,
      num? price,
      num? rating,
      Map<String, dynamic>? images,
      int? cid,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res> implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  final ProductModel _value;
  // ignore: unused_field
  final $Res Function(ProductModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? details = freezed,
    Object? price = freezed,
    Object? rating = freezed,
    Object? images = freezed,
    Object? cid = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num?,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      cid: cid == freezed
          ? _value.cid
          : cid // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$_ProductModelCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$_ProductModelCopyWith(
          _$_ProductModel value, $Res Function(_$_ProductModel) then) =
      __$$_ProductModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? title,
      String? details,
      num? price,
      num? rating,
      Map<String, dynamic>? images,
      int? cid,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$$_ProductModelCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res>
    implements _$$_ProductModelCopyWith<$Res> {
  __$$_ProductModelCopyWithImpl(
      _$_ProductModel _value, $Res Function(_$_ProductModel) _then)
      : super(_value, (v) => _then(v as _$_ProductModel));

  @override
  _$_ProductModel get _value => super._value as _$_ProductModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? details = freezed,
    Object? price = freezed,
    Object? rating = freezed,
    Object? images = freezed,
    Object? cid = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_ProductModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num?,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num?,
      images: images == freezed
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      cid: cid == freezed
          ? _value.cid
          : cid // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$_ProductModel implements _ProductModel {
  const _$_ProductModel(
      {this.id,
      this.title,
      this.details,
      this.price,
      this.rating,
      final Map<String, dynamic>? images,
      this.cid,
      this.createdAt,
      this.updatedAt})
      : _images = images;

  factory _$_ProductModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProductModelFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? details;
  @override
  final num? price;
  @override
  final num? rating;
  final Map<String, dynamic>? _images;
  @override
  Map<String, dynamic>? get images {
    final value = _images;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? cid;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, details: $details, price: $price, rating: $rating, images: $images, cid: $cid, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.details, details) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.rating, rating) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other.cid, cid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(details),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(rating),
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(cid),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      __$$_ProductModelCopyWithImpl<_$_ProductModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductModelToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductModel {
  const factory _ProductModel(
      {final int? id,
      final String? title,
      final String? details,
      final num? price,
      final num? rating,
      final Map<String, dynamic>? images,
      final int? cid,
      final String? createdAt,
      final String? updatedAt}) = _$_ProductModel;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$_ProductModel.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get details;
  @override
  num? get price;
  @override
  num? get rating;
  @override
  Map<String, dynamic>? get images;
  @override
  int? get cid;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}
