import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    int? id,
    String? title,
    String? details,
    num? price,
    num? rating,
    Map<String, dynamic>? images,
    int? cid,
    String? createdAt,
    String? updatedAt,
    // @Default('Tokoto') String marketName,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
