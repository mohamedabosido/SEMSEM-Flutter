// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      details: json['details'] as String?,
      price: json['price'] as num?,
      rating: json['rating'] as num?,
      images: json['images'] as Map<String, dynamic>?,
      cid: json['cid'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'price': instance.price,
      'rating': instance.rating,
      'images': instance.images,
      'cid': instance.cid,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
