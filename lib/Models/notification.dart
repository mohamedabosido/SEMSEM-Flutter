import 'package:tokoto/Models/product.dart';

class NotificationModel {
  final int id;
  final String type;
  final ProductModel product;
  bool isRead;
  final DateTime time = DateTime.now();

  NotificationModel({
    required this.id,
    required this.type,
    required this.product,
    required this.isRead,
  });
}
