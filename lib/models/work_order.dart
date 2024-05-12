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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.toString(),
      'number': number,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deleted': deleted ? 1 : 0,
    };
  }
}