import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';


@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    int? id,
    String? name,
    String? icon,
    String? createdAt,
    String? updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
