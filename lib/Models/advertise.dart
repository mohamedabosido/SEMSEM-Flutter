import 'package:freezed_annotation/freezed_annotation.dart';

part 'advertise.freezed.dart';

part 'advertise.g.dart';

@freezed
class AdvertiseModel with _$AdvertiseModel {
  const factory AdvertiseModel({
    int? id,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) = _AdvertiseModel;

  factory AdvertiseModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertiseModelFromJson(json);
}
