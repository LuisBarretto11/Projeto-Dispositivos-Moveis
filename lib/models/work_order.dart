import 'package:work_order/enum/work_order.dart';

class WorkOrder {
  String id;
  String title;
  String description;
  Status status;
  int number;
  DateTime createdAt;
  DateTime updatedAt;
  bool deleted;

  WorkOrder({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
  });
}