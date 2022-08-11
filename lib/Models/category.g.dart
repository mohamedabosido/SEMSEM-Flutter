// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryModel _$$_CategoryModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_CategoryModelToJson(_$_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
